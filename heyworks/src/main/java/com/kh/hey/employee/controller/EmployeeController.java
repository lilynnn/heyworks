package com.kh.hey.employee.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.hey.approval.model.service.ApprovalService;
import com.kh.hey.approval.model.vo.Approval;
import com.kh.hey.common.model.vo.PageInfo;
import com.kh.hey.common.template.Pagination;
import com.kh.hey.employee.model.service.EmployeeService;
import com.kh.hey.employee.model.vo.Employee;
import com.kh.hey.organization.model.service.OrganizationService;
import com.kh.hey.organization.model.vo.Organ;
import com.kh.hey.reserve.model.service.ReservationService;
import com.kh.hey.reserve.model.vo.Reservation;
import com.kh.hey.todo.model.service.todolistService;
import com.kh.hey.todo.model.vo.Todolist;

@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeService eService;
	
	@Autowired
	private ApprovalService aService;
	
	@Autowired 
	private ReservationService rService;
	
	@Autowired 
	private todolistService tService;
	
	@Autowired 
	private OrganizationService orService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	@RequestMapping("login.em")
	public ModelAndView loginEmployee(Employee e, HttpSession session, ModelAndView mv) {
		
		
		Employee loginUser = eService.loginEmployee(e);
		
		if(loginUser != null && bcryptPasswordEncoder.matches(e.getUserPwd(), loginUser.getUserPwd())) { 
			
			if(e.getUserPwd().equals("1234")) { 
				
				mv.addObject("userId", e.getUserId());
				mv.setViewName("employee/updatePassword");
			
			}else {
				
				session.setAttribute("loginUser", loginUser);
				System.out.println(loginUser);
				mv.setViewName("redirect:/main.do");
			}
			
		}else { 			
			mv.addObject("errorMsg", "????????? ??????");
			System.out.println("????????? ??????");
			System.out.println(loginUser);
			mv.setViewName("redirect:/login.do"); 
		}
		return mv;		
	}
	
	@RequestMapping("login.do")
	public String index(HttpSession session) throws Exception {

		return "employee/login";
	}
	
	@RequestMapping("main.do")
	public String home(@RequestParam(value="cpage", defaultValue="1")int currentPage, Model model, HttpSession session) throws Exception {
		
		// ??????????????? ??????-------------------------------------------------------------
		String userName = ((Employee)session.getAttribute("loginUser")).getUserName();
		String userNo = (String.valueOf(((Employee)session.getAttribute("loginUser")).getUserNo()));
		
		int listCount = aService.selectListCount(userName);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		ArrayList<Approval> apList = aService.selectStandByList(pi, userName);
		
		model.addAttribute("pi", pi);
		model.addAttribute("apList", apList);
		// ???????????? ???-----------------------------------------------------------------

		//???????????? ??????----------------------------------------------------------
		ArrayList<Reservation> list = rService.myReserveList(pi, userNo);
		model.addAttribute("list", list);
		
		//????????????  ???--------------------------------------------------------------
		
		//todolist ?????? ---------------------------------------------
		ArrayList<Todolist> todoList = tService.todolistSelect(userNo);
		int count = tService.todolistCount(userNo);
		model.addAttribute("todoList", todoList);
		model.addAttribute("count", count);
		
		//??????????????? ?????? -----------------------------------------------------------
		Organ emp = orService.mainEmp(userNo);
		model.addAttribute("emp", emp);
		System.out.println(emp);
		
		return "main";
	}
	
	@RequestMapping("logout.em")
	public String logoutMember(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping("myPage.em")
	public String myPage() {
		
		return "employee/myPage";	
		
	}
	
	@RequestMapping("update.em")
	public String updateEmployee(HttpSession session, Employee e) {
		
		int result = eService.updateEmployee(e);
		
		if(result > 0) {
			session.setAttribute("loginUser", eService.loginEmployee(e));
			session.setAttribute("alertMsg", "?????? ????????? ?????????????????????.");
			
			return "redirect:myPage.em";
		}else {
			session.setAttribute("alertMsg", "?????? ?????? ?????? ??????!");
			return "redirect:myPage.em";
		}
		
	} // ??????????????????
	
	@RequestMapping("updatePwdForm.em")
	public ModelAndView updatePwdForm(ModelAndView mv) {
		mv.setViewName("employee/updatePassword");
		return mv;
	} // ???????????? ?????? ????????? 
	
	@RequestMapping("updatePwd.em")
	public String updatePassword(String userPwd, String userId, HttpSession session) {
		
		String encPwd = bcryptPasswordEncoder.encode(userPwd);

		HashMap<String,String> map = new HashMap<String,String>();
		map.put("encPwd", encPwd);
		map.put("userId", userId);
		
		int result = eService.updatePassword(map);
		
		if(result > 0) {
			return "redirect:login.do";
		}else {
			session.setAttribute("alertMsg", "???????????? ?????? ??????!");
			return "redirect:updatePwdForm.em";
		}
		
	} // ???????????? ??????
	
	
	
	
	
	
	
	
	
	
	
	

}
