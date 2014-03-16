98Blog

Personal blog by jsp servlet Dbutils, controled by maven. 


1. At first, you should configure Date source, Tomcat -> context.xml  
          like 
              <Context reloadable="true">
              <Resource
              name="jdbc/dbname"
              type="javax.sql.DataSource"
              maxActive="100"
              maxIdle="30"
              maxWait="5000"
              username="xxx"
              password="xxx"
              driverClassName="数据库的驱动"
              url="数据库的连接地址" />
              </Context>

2. When you add categoroy, Menu Items number order this rule: Main menu number from 10 -40, secondary menu number add xx behind its father menu. such as one main menu of “Java”, you should set the menu number as 10, if you want add the children menu like Java EE, you shoud set the menu number as 1001, then Java SE as 1002 ……
