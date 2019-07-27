/**
 * This file is for performing validations using JavaScript and jQuery
 */


function validate() {
	alert("hello");
	let uname = $("#username").value;
	let passwd = $("#passwd").value;

	if (uname.trim() == "") {
		$("#username").style.border = "solid 3px red;";
		return false;
	}
	if (passwd.trim() == "") {
		$("#passwd").style.border = "solid 3px red;";
		return false;
	}
	return true;
}

/**
 * It checks whether or not, any data, independent of its type(i.e. Object or 
 * Primitive), is empty or null or undefined
 * 
 * @param {*} str A data member to be checked as null or empty or undefined
 * @returns {boolean} true if it is empty or null or undefined, false otherwise 
 */
function isBlank(str) {
	return (!str || /^\s*$/.test(str));
}


/**
 * 
 * It checks whether two data members have equal value or not; It returns true 
 * if they've equal value, false otherwise; It is specifially designed to confirm
 * user entered password matches or not
 * 
 * @param {*} passwd First Value for password matching
 * @param {*} cPasswd First Value for password matching
 * @returns {boolean} true if matches, false otherwise 
 */
function passwordMatches(passwd, cPasswd) {
	if (passwd == cPasswd)
		return true;
	return false;
}
/**
 * 
 * @param {*} email Email that is to be validated
 * @returns {boolean} true if it is a valid email, false otherwise
 */
function validEmail(email) {
	let emailPattern = /^([a-zA-Z0-9._-]+)@([a-zA-Z0-9.-]+)\.([a-zA-Z]{2,4})(.[a-zAZ]{2,4})?$/;
	return emailPattern.test(email);
}

/**
 * It checks a mobile number to be valid indian mobile number i.e. It checks whether
 * or not it starts with any digit 7 to 9 and is of exact length 10
 * 
 * @param {*} email Mobile Number that is to be validated
 * @returns {boolean} true if it is a valid mobile number, false otherwise
 */
function validMobile(mobileNo) {
	let pattern = /^[7-9]\d{9}$/;
	return pattern.test(mobileNo);
}


/**
 *
 * It checks the strength of the password provided as a parameter and returns the strength
 * where -1 is returned to indicate length short than 6 and 0 indicating if it only has either
 * number or characters;
 *
 * Maximum strength possible to return is 5
 *
 * It increases the strength (considering the initial strength as 0) by 1 for each of the following matches
 * 		1. It has 8 or more than 8 characters
 * 		2. If it has both lowercase and uppercase characters
 * 		3. If it has both numbers and characters
 * 		4. If it has one special character
 * 		5. If it has two special characters
 * 
 * @param {*} password A password String whose strength is to be tested
 * @returns {number} Denoting the strength of the password, ranging from -1(Having length less than 6) to 5(Strongest Possible)
 */
function checkPasswordStrength(password) {
	let strength = 0
	if (password.length < 6) {
		$('#result').removeClass();
		$('#result').addClass('short');
		return -1;
	}

	if (password.length > 7)
		strength += 1;

	if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))
		strength += 1;

	if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/))
		strength += 1;

	if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/))
		strength += 1;

	if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,",%,&,@,#,$,^,*,?,_,~])/))
		strength += 1;

	return strength;
}