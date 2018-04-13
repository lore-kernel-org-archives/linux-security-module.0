From: shinya1.takumi@toshiba.co.jp (shinya1.takumi at toshiba.co.jp)
Date: Fri, 13 Apr 2018 04:30:30 +0000
Subject: [RFC v3 0/2] WhiteEgret LSM module
In-Reply-To: <20180408155114.GE9715@mail.hallyn.com>
References: <20180330083031.2199-1-masanobu2.koike@toshiba.co.jp>
	<20180401200827.GA28101@mail.hallyn.com>
	<OSBPR01MB21847D1D8A8BC8458CBAD39592BB0@OSBPR01MB2184.jpnprd01.prod.outlook.com>
	<20180408155114.GE9715@mail.hallyn.com>
Message-ID: <OSBPR01MB2184E8C11A5DEDA145A3B40E92B30@OSBPR01MB2184.jpnprd01.prod.outlook.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> Do you have a target date for posting that?
Yes, we have the target date. We will submit WhiteEgret v4 by September.

> So you have a design for being able to differentiate the interpreters 
> reading versus reading with the intent to execute?
> With or without their help?
We will provide WEUA sample to be able to control a script program with WhiteEgret v4.
Our WEUA sample does not identify whether to read or to read with the intent to execute. 
The sample has some restrictions.

We consider that the restrictions can be resolved by implementing additional functions for WEUA.
It is an implementation-dependent matter.

Howerver, we are sure that the restrictions are acceptable for many applications.
We would like to discuss about them with WhiteEgret v4 patch!

-----Original Message-----
> I am one of developers of WhiteEgret.
> 
> > regardling the last one, do you have a plan for handling it?
> Yes, we have a plan to release WhiteEgret v4 patch with a WEUA sample of access control for script programs.

Do you have a target date for posting that?

> The latest WhiteEgret cannot control script programs since script files read by an interpreter are not hooked by the execve system call.
> We consider that script programs can be controlled by controlling the files inputted by interpreters, accordingly. 
> We consider that the control can be realized using the read system call hooking.

So you have a design for being able to differentiate the interpreters reading versus reading with the intent to execute?  With or without their help?

> Now, we are developing WhiteEgret with the read system call hooking and WEUA which controls the script files to be read to interpreters using information from the read system call hooking and white list.

-serge


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
