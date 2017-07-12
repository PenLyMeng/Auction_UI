package org.khmeracademy.auction.repository;

import java.util.ArrayList;


import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.khmeracademy.auction.entities.Role;
import org.khmeracademy.auction.entities.User;
import org.springframework.stereotype.Repository;


@Repository
public interface UserRepository {
	
//	String R_USERBYNAME = "SELECT ";
//	public User findUserByUserName(@Param("user_name") String user_name);
//	
//	
//	String R_ROLE="SELECT role_id, role_name FROM AUC_role WHERE role_id=#{role_id}";
//	@Select(R_ROLE)
//	@Results(value = {
//		@Result(property="role_id" , column="role_id"),
//		@Result(property="role_name" , column="role_name")
//	})
//	public ArrayList<Role> findRolesByRoleId( int role_id);
}
