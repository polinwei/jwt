<#include "/layout/AdminLTE2/vueHtml-begin.ftl">
<#include "/layout/AdminLTE2/content-auth-begin.ftl">

<link rel="stylesheet" href="/css/elementUI.css">


<div id="app">
<div class="box box-danger">
	<div class="box-body">
	
<el-form :model="ruleForm" :rules="rules" ref="ruleForm" class="">
<input type="hidden" v-model="ruleForm.uId" id="companyId" name="uId" >
	<div class="row">
		<div class="col-md-6">
		<div class="form-group">
		  <el-form-item label='<@spring.message "program.userController.firstName" />' prop="name" >
		    <el-input v-model="ruleForm.name"></el-input>
		  </el-form-item>
		  </div>
  		</div>
  		
  		<div class="col-md-6">
  		<div class="form-group">
		  <el-form-item label="Activity zone" prop="region">
		    <el-select v-model="ruleForm.region" placeholder="Activity zone">
		      <el-option label="Zone one" value="shanghai"></el-option>
		      <el-option label="Zone two" value="beijing"></el-option>
		    </el-select>
		  </el-form-item>
		</div>
  		</div>
  	</div>
	<div class="row">
		<div class="col-md-6">
		<div class="form-group">  	
		  <el-form-item label="Activity time" required>
		    <div class="col-md-6">
		      <el-form-item prop="date1">
		        <el-date-picker type="date" placeholder="Pick a date" v-model="ruleForm.date1" style="width: 100%;"></el-date-picker>
		      </el-form-item>
		    </div>
		    
		    <div class="col-md-6">
		      <el-form-item prop="date2">
		        <el-time-picker placeholder="Pick a time" v-model="ruleForm.date2" style="width: 100%;"></el-time-picker>
		      </el-form-item>
		    </div>
		  </el-form-item>
		</div>
  		</div>
		<div class="col-md-6">
		<div class="form-group"> 
		  <el-form-item label="Instant delivery" prop="delivery">
		    <el-switch v-model="ruleForm.delivery"></el-switch>
		  </el-form-item>		
		</div>
  		</div>  		
  	</div>  
	<div class="row">
		<div class="col-md-12">
		<div class="form-group"> 
		  <el-form-item label="Activity type" prop="type">
		    <el-checkbox-group v-model="ruleForm.type">
		      <el-checkbox label="Online activities" name="type"></el-checkbox>
		      <el-checkbox label="Promotion activities" name="type"></el-checkbox>
		      <el-checkbox label="Offline activities" name="type"></el-checkbox>
		      <el-checkbox label="Simple brand exposure" name="type"></el-checkbox>
		    </el-checkbox-group>
		  </el-form-item>
		</div>
  		</div>  		
  	</div>   

	<div class="row">
		<div class="col-md-6">
		<div class="form-group"> 
			<el-form-item label="Resources" prop="resource">
			    <el-radio-group v-model="ruleForm.resource">
			      <el-radio label="Sponsorship"></el-radio>
			      <el-radio label="Venue"></el-radio>
			    </el-radio-group>
			</el-form-item>
		</div>
  		</div> 			  
		<div class="col-md-6">
		<div class="form-group"> 			  
			  <el-form-item label="Activity form" prop="desc">
			    <el-input type="textarea" v-model="ruleForm.desc"></el-input>
			  </el-form-item>
		</div>
  		</div>  		
  	</div>
	<div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<el-form-item label='list suggestions on input' prop="auto1">
				    <el-autocomplete
				      class="inline-input"
				      size="medium"
				      v-model="ruleForm.auto1"
				      :fetch-suggestions="aSearch"
				      placeholder="List suggestions on input"
				      :trigger-on-focus="false"
				      @select="handleSelect"
				      style="width: 100%;"
				    >				    
				    </el-autocomplete>
				    
				</el-form-item>
			</div><#-- /.form-group -->
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<el-form-item label='list suggestions of companies on input' prop="auto2">
				    <el-autocomplete
				      class="my-autocomplete"
				      size="medium"
				      v-model="ruleForm.auto2"
				      :fetch-suggestions="bSearch"
				      placeholder="List suggestions on input"
				      :trigger-on-focus="true"
				      @select="handleSelect"
				      style="width: 100%;"
				    >
				    <el-button slot="append" icon="el-icon-search"></el-button>
					<template slot-scope="{ item }">
					   <div class="name">{{ item.value }}</div>
					   <span class="addr">{{ item.firstname }}-{{ item.lastname }}</span>
					</template>
				    </el-autocomplete>
				    
				</el-form-item>
			</div><#-- /.form-group -->
		</div>		
	</div>  	
	  <el-form-item>
	    <el-button type="primary" @click="submitForm('ruleForm')">Create</el-button>
	    <el-button @click="resetForm('ruleForm')">Reset</el-button>
	  </el-form-item>
	</el-form>
</div> <!-- ./box-body -->

</div></div>

<script>
var tagAInput = {
	data(){
		return {
			tagAInputDatas: []
		}
	},
  mounted() {
	  console.log('loading tagAInput Data!')
	  this.tagAInputDatas = [
          { "value": "vue", "link": "https://github.com/vuejs/vue" },
          { "value": "element", "link": "https://github.com/ElemeFE/element" },
          { "value": "cooking", "link": "https://github.com/ElemeFE/cooking" },
          { "value": "mint-ui", "link": "https://github.com/ElemeFE/mint-ui" },
          { "value": "vuex", "link": "https://github.com/vuejs/vuex" },
          { "value": "vue-router", "link": "https://github.com/vuejs/vue-router" },
          { "value": "babel", "link": "https://github.com/babel/babel" }
         ];
  },
  methods: {
    hello: function () {
      console.log('hello from mixin!')
    },
    aSearch(queryString, cb){
    	console.log(queryString)
    	var links = this.tagAInputDatas;
        var results = queryString ? links.filter(this.inputFilter(queryString)) : links;
        // call callback function to return suggestions
        cb(results);
    },
    handleSelect(item) {
        console.log(item);
    }
  }
};

var tagBInput = {
	data(){
		return {
			tagBInputDatas: []
		}
	},
	mounted() {
		console.log('loading tagBInput Data!');
		/* 送出GET */
		axios.get('/auth/org/allUserInfo')
		  .then(function (response) {
		    /* 成功拿到資料，然後... */
				tagBInputDatas =response.data;
		  })
		  .catch(function (error) {
		    /* 失敗，發生錯誤，然後...*/
		  });
		//this.tagBInputDatas = [{"departmentName":"總部","companyCode":"DB","firstname":"管理員","hireDate":"1900-01-01T00:00:00+0000","departmentId":1,"companyName":"資料庫公司","jobTitle":"Administrator","userDetailId":1,"userManagerId":null,"avatar":"avatar2.png","empNo":"1","workAddress":null,"resignationDate":"1900-01-01T00:00:00+0000","enabled":true,"lastname":"admin","uid":1,"companyId":1,"password":"$2a$08$lDnHPz7eUkSi6ao14Twuau08mzhWrL4kyZGGU5xfiGALO/Vxd5DOi","deptManagerId":null,"inactiveDate":null,"activeDate":null,"value":"admin","email":"admin@admin.com","username":"admin"},{"firstname":"Polin","departmentId":100,"companyName":"範例公司","jobTitle":"CEO","userDetailId":100,"userManagerId":null,"enabled":true,"uid":5,"password":"$2a$10$mCjJJgf1e8UFEGvxcUr9SOdA6A5YbhXOj2HZz3l7zZwG34xIcUm1e","deptManagerName":"admin","inactiveDate":null,"activeDate":null,"value":"polin.wei","email":"polin.wei@gmail.com","companyCode":"Demo","departmentName":"總經理室","hireDate":"1996-03-01T00:00:00+0000","avatar":"avatar4.png","empNo":"100","resignationDate":null,"workAddress":null,"lastname":"WEI","companyId":100,"deptManagerId":1,"username":"polin.wei"},{"firstname":"Polin","departmentId":101,"companyName":"範例公司","jobTitle":"CFO","userDetailId":101,"userManagerId":null,"enabled":true,"uid":5,"password":"$2a$10$mCjJJgf1e8UFEGvxcUr9SOdA6A5YbhXOj2HZz3l7zZwG34xIcUm1e","deptManagerName":"polin.wei","inactiveDate":null,"activeDate":null,"value":"polin.wei","email":"polin.wei@gmail.com","departmentName":"管理室","companyCode":"Demo","hireDate":"1996-03-01T00:00:00+0000","avatar":"avatar4.png","empNo":"101","resignationDate":null,"workAddress":null,"lastname":"WEI","companyId":100,"deptManagerId":5,"username":"polin.wei"},{"firstname":"Polin","departmentId":102,"companyName":"範例公司","jobTitle":"Dircetor","userDetailId":102,"userManagerId":3,"enabled":true,"uid":5,"password":"$2a$10$mCjJJgf1e8UFEGvxcUr9SOdA6A5YbhXOj2HZz3l7zZwG34xIcUm1e","deptManagerName":"polin.wei","inactiveDate":null,"activeDate":null,"value":"polin.wei","email":"polin.wei@gmail.com","companyCode":"Demo","departmentName":"IT","hireDate":"1996-03-01T00:00:00+0000","avatar":"avatar4.png","empNo":"102","resignationDate":null,"workAddress":"","lastname":"WEI","companyId":100,"deptManagerId":5,"userManagerName":"disabled","username":"polin.wei"},{"firstname":"user","departmentId":102,"companyName":"範例公司","jobTitle":"Engineer","userDetailId":103,"userManagerId":5,"enabled":true,"uid":2,"password":"$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC","deptManagerName":"polin.wei","inactiveDate":null,"activeDate":null,"value":"user","email":"enabled@user.com","companyCode":"Demo","departmentName":"IT","hireDate":"2019-03-01T00:00:00+0000","avatar":"avatar3.png","empNo":"103","resignationDate":null,"workAddress":"TW","lastname":"user","companyId":100,"deptManagerId":5,"userManagerName":"polin.wei","username":"user"},{"firstname":"Polin","companyName":"範例公司","jobTitle":"Manager","departmentId":104,"userDetailId":104,"userManagerId":1,"enabled":true,"uid":5,"password":"$2a$10$mCjJJgf1e8UFEGvxcUr9SOdA6A5YbhXOj2HZz3l7zZwG34xIcUm1e","deptManagerName":"polin.wei","inactiveDate":null,"activeDate":null,"value":"polin.wei","email":"polin.wei@gmail.com","departmentName":"ERP","companyCode":"Demo","hireDate":null,"avatar":"avatar4.png","empNo":"104","resignationDate":null,"workAddress":"Taiwan","lastname":"WEI","companyId":100,"deptManagerId":5,"userManagerName":"admin","username":"polin.wei"}];
	},
	methods: {
		bSearch(queryString, cb){
	    	console.log(queryString)
	    	var links = tagBInputDatas;
	        var results = queryString ? links.filter(this.inputFilter(queryString)) : links;
	        // call callback function to return suggestions
	        cb(results);
	    }
	}
}

var tagBase = {
		methods: {
		    inputFilter(queryString) {
		        return (code) => {
		          return (code.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
		        };
		    }
		}
}

var Main = {
	    data() {
	      return {
	        ruleForm: {
	          uId:'',
	          name: '',
	          region: '',
	          date1: '',
	          date2: '',
	          delivery: false,
	          type: [],
	          resource: '',
	          desc: '',
	          auto1:'',
	          auto2:''
	        },
	        rules: {
	          name: [
	            { required: true, message: 'Please input Activity name', trigger: 'blur' },
	            { min: 3, max: 5, message: 'Length should be 3 to 5', trigger: 'blur' }
	          ],
	          region: [
	            { required: true, message: 'Please select Activity zone', trigger: 'change' }
	          ],
	          date1: [
	            { type: 'date', required: true, message: 'Please pick a date', trigger: 'change' }
	          ],
	          date2: [
	            { type: 'date', required: true, message: 'Please pick a time', trigger: 'change' }
	          ],
	          type: [
	            { type: 'array', required: true, message: 'Please select at least one activity type', trigger: 'change' }
	          ],
	          resource: [
	            { required: true, message: 'Please select activity resource', trigger: 'change' }
	          ],
	          desc: [
	            { required: true, message: 'Please input activity form', trigger: 'blur' }
	          ]
	        }
	      };
	    },
	    mixins: [tagBase,tagAInput,tagBInput],	    
	    methods: {
	      submitForm(formName) {
	        this.$refs[formName].validate((valid) => {
	          if (valid) {
	            alert('submit!');
	          } else {
	            console.log('error submit!!');
	            return false;
	          }
	        });
	      },
	      resetForm(formName) {
	        this.$refs[formName].resetFields();
	      },
	      querySearch(queryString, cb) {
	          var links = this.links;
	          var results = queryString ? links.filter(this.createFilter(queryString)) : links;
	          // call callback function to return suggestions
	          cb(results);
	        }
	    }
};
var Ctor = Vue.extend(Main)
var vueCtor = new Ctor().$mount('#app')

	
</script>
<style>
.my-autocomplete {
  li {
    line-height: normal;
    padding: 7px;

    .name {
      text-overflow: ellipsis;
      overflow: hidden;
    }
    .addr {
      font-size: 12px;
      color: #b4b4b4;
    }

    .highlighted .addr {
      color: #ddd;
    }
  }
}
</style>

<#include "/layout/AdminLTE2/controlSidebar.ftl">
<#include "/layout/AdminLTE2/content-auth-end.ftl">
<#include "/layout/AdminLTE2/html-end.ftl"> 