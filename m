From: james.l.morris@oracle.com (James Morris)
Date: Mon, 4 Dec 2017 11:51:55 +1100 (AEDT)
Subject: KASAN: slab-out-of-bounds Read in strcmp
In-Reply-To: <201712032227.JCH90603.HQOOtVFMJOFLSF@I-love.SAKURA.ne.jp>
References: <001a113f711a721c58055f052200@google.com>
	<089e08259d282c063e055f4bddbd@google.com>
	<97d6bab0-d278-9945-5d82-a0a76b8b78c5@I-love.SAKURA.ne.jp>
	<201712032227.JCH90603.HQOOtVFMJOFLSF@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LFD.2.20.1712041150270.1348@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 3 Dec 2017, Tetsuo Handa wrote:

> Tetsuo Handa wrote:
> > which will allow strcmp() to trigger out of bound read when "size" is
> > larger than strlen(initial_sid_to_string[i]).
> 
> Oops. "smaller" than.
> 
> > 
> > Thus, I guess the simplest fix is to use strncmp() instead of strcmp().
> 
> Can somebody test below patch? (My CentOS 7 environment does not support
> enabling SELinux in linux.git . Userspace tool is too old to support?)

You mean enabling KASAN?  Yep, you need gcc 4.9.2 or better.  Recent 
Fedora has it.


-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
