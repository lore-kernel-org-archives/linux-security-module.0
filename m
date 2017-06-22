From: steve@steve.fi (Steve Kemp)
Date: Thu, 22 Jun 2017 17:21:24 +0000
Subject: [PATCH v2] Moved module init-functions into the module.
In-Reply-To: <CAGXu5jJb8vc3Og7Mk2LUYvnJT2tZ4_W3MRPetJWtUEpAGZupXg@mail.gmail.com>
References: <20170622084507.GA4025@steve.org.uk>
	<589cbc78-2256-2334-e907-2e440f99b612@schaufler-ca.com>
	<CAGXu5jJb8vc3Og7Mk2LUYvnJT2tZ4_W3MRPetJWtUEpAGZupXg@mail.gmail.com>
Message-ID: <1498152084.15628.1@ssh.steve.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> > The module initialization code belongs in the module.
> > The LSM infrastructure should have an absolute minimum
> > of module specific information. I would rather see the
> > "minor" modules (yama, loadpin) changed to use the module
> > registration scheme used by the "major" modules, but that
> > will require a mechanism to ensure module ordering, and
> > we don't have that yet. No, don't do this.
> 
> Yeah, I agree: initialization order is important here and I don't want
> to depend on the Makefile for this.

  I can appreciate that argument.  I did consider it myself,
 but decided that because the minor modules had such differing
 goals, and no real functional overlap, in practice that would
 mean that explicit ordering wasn't a strong requirement.

  If/when a better registration scheme becomes available then
 we'll all switch to using it, and that would be great.

  Thanks for the feedback.  I'll not tweak any further.

Steve
-- 
https://steve.fi/
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
