From: shinya1.takumi@toshiba.co.jp (shinya1.takumi at toshiba.co.jp)
Date: Thu, 5 Apr 2018 06:40:36 +0000
Subject: [RFC v3 0/2] WhiteEgret LSM module
In-Reply-To: <20180401200827.GA28101@mail.hallyn.com>
References: <20180330083031.2199-1-masanobu2.koike@toshiba.co.jp>
	<20180401200827.GA28101@mail.hallyn.com>
Message-ID: <OSBPR01MB21847D1D8A8BC8458CBAD39592BB0@OSBPR01MB2184.jpnprd01.prod.outlook.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I am one of developers of WhiteEgret.

> regardling the last one, do you have a plan for handling it?
Yes, we have a plan to release WhiteEgret v4 patch with a WEUA sample of access control for script programs.

The latest WhiteEgret cannot control script programs since script files read by an interpreter are not hooked by the execve system call.
We consider that script programs can be controlled by controlling the files inputted by interpreters, accordingly. 
We consider that the control can be realized using the read system call hooking.

Now, we are developing WhiteEgret with the read system call hooking and WEUA which controls the script files to be read to interpreters using information from the read system call hooking and white list.

-----Original Message-----
From: owner-linux-security-module@vger.kernel.org [mailto:owner-linux-security-module at vger.kernel.org] On Behalf Of Serge E. Hallyn
Sent: Monday, April 2, 2018 5:08 AM
To: koike masanobu(?? ?? ???? ????????????) <masanobu2.koike@toshiba.co.jp>
Cc: jmorris at namei.org; serge at hallyn.com; linux-security-module at vger.kernel.org; linux-kernel at vger.kernel.org
Subject: Re: [RFC v3 0/2] WhiteEgret LSM module

Quoting Masanobu Koike (masanobu2.koike at toshiba.co.jp):
...
> Assumptions and ToDos
> 
> At this stage, WhiteEgret assumes the following.
> Relaxing these assumptions are future works.
> - Root is not compromised. And using a whitelist and a WEUA requires 
> root privilege.
> - WEUA is reliable.
> - It is allowed for scripting languages, e.g., Perl or Python, to read 
> arbitrary scripts and to execute them.

Hi,

regardling the last one, do you have a plan for handling it?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in the body of a message to majordomo at vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
