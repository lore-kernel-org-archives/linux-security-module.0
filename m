From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Tue, 5 Dec 2017 22:21:24 +0900
Subject: [PATCH] security: Export few symbols referred by other modules
In-Reply-To: <alpine.LFD.2.20.1712052259390.14735@localhost>
References: <1512471537-23865-1-git-send-email-hareeshg@codeaurora.org>
	<alpine.LFD.2.20.1712052259390.14735@localhost>
Message-ID: <201712052221.HDJ00044.tOOHVMFQFOJLSF@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James Morris wrote:
> On Tue, 5 Dec 2017, Hareesh Gundu wrote:
> 
> > Export mmap_min_addr and security_mmap_addr() to allow
> > kernel modules to use them.
> > 
> > Signed-off-by: Hareesh Gundu <hareeshg@codeaurora.org>
> 
> I'm not sure whether this should be EXPORT_SYMBOL or EXPORT_SYMBOL_GPL, as 
> this hook was added in 2009, well after EXPORT_SYMBOL_GPL came into being.
> 
> Most of the LSM hooks are marked EXPORT_SYMBOL because they were part of 
> an existing interface when EXPORT_SYMBOL_GPL was introduced, IIRC.
> 
> What do folks think?
> 
We don't export symbols not used by in-tree modules.
Which in-tree module needs to access these symbols?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
