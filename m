From: matt@nmatt.com (Matt Brown)
Date: Fri, 9 Jun 2017 12:37:50 -0400
Subject: [PATCH v1] shebang: restrict python interactive prompt/interpreter
In-Reply-To: <201706100041.GFH78616.OFtOHFJSLQOMVF@I-love.SAKURA.ne.jp>
References: <1497014528.21594.190.camel@linux.vnet.ibm.com>
	<201706092302.HCE57804.OSFJFVtMLOQHFO@I-love.SAKURA.ne.jp>
	<bf9f44f5-7b9c-dff1-10e0-84c866c3a372@nmatt.com>
	<201706100041.GFH78616.OFtOHFJSLQOMVF@I-love.SAKURA.ne.jp>
Message-ID: <754b78d1-f7f9-58bd-bf74-fea9e105649a@nmatt.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/9/17 11:41 AM, Tetsuo Handa wrote:
> Matt Brown wrote:
>>> What about execution via ld-linux ?
>>>
>>>    $ /lib64/ld-linux-x86-64.so.2 /usr/bin/python2
>>>
>>
>> Just tested this and you are correct, this allows you to bypass the
>> protection.
>>
>> I was able to fix this bypass by including /lib64/ld-linux-x86-64.so.2
>> in the list of interpreters.
> 
> And there is also PYTHONINSPECT environment variable. ;-)
> 
> # echo '#!/usr/bin/python2' > run-python
> # chmod 755 run-python
> # ./run-python
> # PYTHONINSPECT=yes ./run-python
>>>> print "hello"
> hello
>>>>

While this bypass works against this LSM alone, when combined with
Trusted Path Execution this is prevented for non-root/untrusted user.
This is why I feel like this is such a great feature to combine with TPE
as I said here:

http://www.openwall.com/lists/kernel-hardening/2017/06/09/13

Results from my test:

$ PYTHONINSPECT=yes ./run-python


-bash: ./run-python: /usr/bin/python2: bad interpreter: Operation not
permitted

and in the dmesg log:
TPE: Denied exec of /home/test/run-python Reason: file in non-root-owned
directory

Matt
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
