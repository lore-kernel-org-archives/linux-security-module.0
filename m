From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Mon, 4 Dec 2017 23:07:56 +0900
Subject: KASAN: slab-out-of-bounds Read in strcmp
In-Reply-To: <1512395025.20988.3.camel@tycho.nsa.gov>
References: <001a113f711a721c58055f052200@google.com>
	<089e08259d282c063e055f4bddbd@google.com>
	<97d6bab0-d278-9945-5d82-a0a76b8b78c5@I-love.SAKURA.ne.jp>
	<1512395025.20988.3.camel@tycho.nsa.gov>
Message-ID: <201712042307.ACI78163.JOVFOLOtHFMFSQ@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Stephen Smalley wrote:
> > Thus, I guess the simplest fix is to use strncmp() instead of
> > strcmp().
> 
> Already fixed by
> https://www.spinics.net/lists/selinux/msg23589.html
> 

OK, I thought everyone was too busy.
I would appreciate if you responded to all.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
