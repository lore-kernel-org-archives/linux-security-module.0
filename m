From: serge@hallyn.com (Serge E. Hallyn)
Date: Sun, 8 Apr 2018 10:51:15 -0500
Subject: [RFC v3 0/2] WhiteEgret LSM module
In-Reply-To: <OSBPR01MB21847D1D8A8BC8458CBAD39592BB0@OSBPR01MB2184.jpnprd01.prod.outlook.com>
References: <20180330083031.2199-1-masanobu2.koike@toshiba.co.jp>
	<20180401200827.GA28101@mail.hallyn.com>
	<OSBPR01MB21847D1D8A8BC8458CBAD39592BB0@OSBPR01MB2184.jpnprd01.prod.outlook.com>
Message-ID: <20180408155114.GE9715@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting shinya1.takumi at toshiba.co.jp (shinya1.takumi at toshiba.co.jp):
> I am one of developers of WhiteEgret.
> 
> > regardling the last one, do you have a plan for handling it?
> Yes, we have a plan to release WhiteEgret v4 patch with a WEUA sample of access control for script programs.

Do you have a target date for posting that?

> The latest WhiteEgret cannot control script programs since script files read by an interpreter are not hooked by the execve system call.
> We consider that script programs can be controlled by controlling the files inputted by interpreters, accordingly. 
> We consider that the control can be realized using the read system call hooking.

So you have a design for being able to differentiate the interpreters reading
versus reading with the intent to execute?  With or without their help?

> Now, we are developing WhiteEgret with the read system call hooking and WEUA which controls the script files to be read to interpreters using information from the read system call hooking and white list.

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
