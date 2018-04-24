From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Tue, 24 Apr 2018 23:46:38 +0900
Subject: [PATCH 1/3] big key: get rid of stack array allocation
In-Reply-To: <20180424143539.GB3125@cisco>
References: <20180424010321.14739-1-tycho@tycho.ws>
	<20180424045015.GA4281@sol.localdomain>
	<20180424143539.GB3125@cisco>
Message-ID: <201804242346.FHI69745.SQMHFVOOFLFOJt@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Tycho Andersen wrote:
> > > +	if (unlikely(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE)) {
> > > +		WARN(1, "big key algorithm changed?");

Please avoid using WARN() WARN_ON() etc.
syzbot would catch it and panic() due to panic_on_warn == 1.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
