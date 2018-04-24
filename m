From: serge@hallyn.com (Serge E. Hallyn)
Date: Tue, 24 Apr 2018 14:58:45 -0500
Subject: [PATCH 1/3] big key: get rid of stack array allocation
In-Reply-To: <20180424145104.GC3125@cisco>
References: <20180424010321.14739-1-tycho@tycho.ws>
	<20180424045015.GA4281@sol.localdomain>
	<20180424143539.GB3125@cisco>
	<201804242346.FHI69745.SQMHFVOOFLFOJt@I-love.SAKURA.ne.jp>
	<20180424145104.GC3125@cisco>
Message-ID: <20180424195845.GB23575@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Tycho Andersen (tycho at tycho.ws):
> On Tue, Apr 24, 2018 at 11:46:38PM +0900, Tetsuo Handa wrote:
> > Tycho Andersen wrote:
> > > > > +	if (unlikely(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE)) {
> > > > > +		WARN(1, "big key algorithm changed?");
> > 
> > Please avoid using WARN() WARN_ON() etc.
> > syzbot would catch it and panic() due to panic_on_warn == 1.
> 
> But it is really a programming bug in this case (and it seems better
> than BUG()...). Isn't this exactly the sort of case we want to catch?
> 
> Tycho

Right - is there a url to some discussion about this?  Because not
using WARN when WARN should be used, because it troubles a bot, seems
the wrong solution.  If this *is* what's been agreed upon, then
what is the new recommended thing to do here?

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
