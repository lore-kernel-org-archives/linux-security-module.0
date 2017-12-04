From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Mon, 4 Dec 2017 19:49:10 +0900
Subject: KASAN: slab-out-of-bounds Read in strcmp
In-Reply-To: <201712041944.HAI56745.HOFQFtJSOVMOFL@I-love.SAKURA.ne.jp>
References: <089e08259d282c063e055f4bddbd@google.com>
	<97d6bab0-d278-9945-5d82-a0a76b8b78c5@I-love.SAKURA.ne.jp>
	<201712032227.JCH90603.HQOOtVFMJOFLSF@I-love.SAKURA.ne.jp>
	<alpine.LFD.2.20.1712041150270.1348@localhost>
	<201712041944.HAI56745.HOFQFtJSOVMOFL@I-love.SAKURA.ne.jp>
Message-ID: <201712041949.DEG35990.VFQOSFOtJOHMFL@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Tetsuo Handa wrote:
> James Morris wrote:
> > On Sun, 3 Dec 2017, Tetsuo Handa wrote:
> > 
> > > Tetsuo Handa wrote:
> > > > which will allow strcmp() to trigger out of bound read when "size" is
> > > > larger than strlen(initial_sid_to_string[i]).
> > > 
> > > Oops. "smaller" than.
> > > 
> > > > 
> > > > Thus, I guess the simplest fix is to use strncmp() instead of strcmp().
> > > 
> > > Can somebody test below patch? (My CentOS 7 environment does not support
> > > enabling SELinux in linux.git . Userspace tool is too old to support?)
> > 
> > You mean enabling KASAN?  Yep, you need gcc 4.9.2 or better.  Recent 
> > Fedora has it.
> 
> I was not able to find "SELinux:  Initializing." line for some reason, and
> it turned out that I just forgot to run "make install". ;-)
> 
> I tested using debug printk() and init for built-in initramfs shown below.
> It is strange that KASAN does not trigger upon strcmp()ing
> initial_sid_to_string[1]. But anyway, my patch fixes this problem.

Sorry for noise. It was just initial_sid_to_string[10] which compared the second byte.
Thus, nothing is strange.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
