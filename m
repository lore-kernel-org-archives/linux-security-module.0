From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sun, 30 Apr 2017 11:11:41 +0900
Subject: [PATCH v1] LSM: Enable multiple calls to security_add_hooks() for
	the same LSM
In-Reply-To: <da65a5ff-62a3-f755-1e8c-bf91a03fd1c9@schaufler-ca.com>
References: <20170429190257.27137-1-mic@digikod.net>
	<da65a5ff-62a3-f755-1e8c-bf91a03fd1c9@schaufler-ca.com>
Message-ID: <201704301111.CFC52113.LFVFQJtFOOMHOS@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler wrote:
> On 4/29/2017 12:02 PM, Mickael Salaun wrote:
> > Check if the registering LSM already registered hooks just before. This
> > enable to split hook declarations into multiple files without
> > registering multiple time the same LSM name, starting from commit
> > d69dece5f5b6 ("LSM: Add /sys/kernel/security/lsm").
> 
> What's special about the previous registration? Keep it
> simple and check it the name is already anywhere on the
> list and only add it if it's not already there. I don't
> see advantage to:
> 
> 	% cat /sys/kernel/security/lsm
> 	capability,yama,spiffy,selinux,spiffy
> 
> over
> 	% cat /sys/kernel/security/lsm
> 	capability,yama,spiffy,selinux
> 

-	if (lsm_append(lsm, &lsm_names) < 0)
+	if (lsm && lsm_append(lsm, &lsm_names) < 0)

in security_add_hooks()?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
