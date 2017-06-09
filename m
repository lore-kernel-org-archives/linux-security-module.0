From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sat, 10 Jun 2017 00:41:37 +0900
Subject: [PATCH v1] shebang: restrict python interactive prompt/interpreter
In-Reply-To: <bf9f44f5-7b9c-dff1-10e0-84c866c3a372@nmatt.com>
References: <1497014528.21594.190.camel@linux.vnet.ibm.com>
	<201706092302.HCE57804.OSFJFVtMLOQHFO@I-love.SAKURA.ne.jp>
	<bf9f44f5-7b9c-dff1-10e0-84c866c3a372@nmatt.com>
Message-ID: <201706100041.GFH78616.OFtOHFJSLQOMVF@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Matt Brown wrote:
> > What about execution via ld-linux ?
> > 
> >    $ /lib64/ld-linux-x86-64.so.2 /usr/bin/python2
> > 
> 
> Just tested this and you are correct, this allows you to bypass the
> protection.
> 
> I was able to fix this bypass by including /lib64/ld-linux-x86-64.so.2
> in the list of interpreters.

And there is also PYTHONINSPECT environment variable. ;-)

# echo '#!/usr/bin/python2' > run-python
# chmod 755 run-python
# ./run-python
# PYTHONINSPECT=yes ./run-python
>>> print "hello"
hello
>>>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
