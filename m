Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B425A2EAB8E;
	Wed, 18 Feb 2026 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771414739; cv=none; b=sUiFyyVqAPkLabAyJBeDJU93UEkLiU8poh1kSWOcQPa8fJ6eMz7mCVb4IbtfhROP7Aibet6iwm7PB0F0Kk6GEiRqqVFqcTQaqTsR02YWXJtp6tAz4u6iJBy8G9Sl8+U90OdyUWllKzzcWnSLQjpiOyxJ2c40IKjhBSmGON3Vm+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771414739; c=relaxed/simple;
	bh=ESF0rDEaW+rFYEcLws1XSz/wLvZKHkMgWRzlrIQhZ+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA+Gna+Z/Vj91INvddIBNtTbIy7ucXQU/JiR7D94iBfWqnGD8sYojaZmTceSCbHRvhOQGJw8u5sOC3WNtPIHViPq/HQLsldOvxFPP+LhbspCCnSiai+CZ1rmOAKZPgIYy0NPvY4l5TVsUhWnCKXMKArHOdSbhu4uLNsT754PYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 61IBF6K8031019;
	Wed, 18 Feb 2026 05:15:06 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 61IBF4eZ031018;
	Wed, 18 Feb 2026 05:15:04 -0600
Date: Wed, 18 Feb 2026 05:15:04 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] security: add LSM blob and hooks for namespaces
Message-ID: <20260218111504.GA30219@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org> <fb40e938-f6b2-45cf-b8ab-246cd6939582@schaufler-ca.com> <20260217-glasur-hinnimmt-ac72b3e67661@brauner>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217-glasur-hinnimmt-ac72b3e67661@brauner>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 18 Feb 2026 05:15:06 -0600 (CST)

On Tue, Feb 17, 2026 at 10:38:33AM +0100, Christian Brauner wrote:

Good morning, I hope the week is going well for everyone.

> On Mon, Feb 16, 2026 at 09:34:57AM -0800, Casey Schaufler wrote:
> > On 2/16/2026 5:52 AM, Christian Brauner wrote:
> > > All namespace types now share the same ns_common infrastructure. Extend
> > > this to include a security blob so LSMs can start managing namespaces
> > > uniformly without having to add one-off hooks or security fields to
> > > every individual namespace type.
> > 
> > The implementation appears sound.
> > 
> > I have to question whether having LSM controls on namespaces is reasonable.

> This is already in active use today but only in a very limited capacity.
> This generalizes it.

This seems to be a tacid indication of the need for namespace specific
LSM policies and/or controls, and further acknowledgement, that such
controls are in active use out in the wild.

More below on the implications of this.

> > I suppose that you could have a system where (for example) SELinux runs
> > in permissive mode except within a specific user namespace, where it would
> > enforce policy. Do you have a use case in mind?

> We will use it in systemd services and containers to monitor and
> supervise namespaces.

Christian, you are no doubt not familiar with our work, but over the
last six years our team has developed and have in production the most
sophisticated implementation of LSM namespacing that has been done.
With the caveat, of course, of implementations that have been made
public.

That work has been driven by what is the clear and apparent need to
have namespace specific and orthogonal security controls and policies,
something your patch and comments seems to clearly acknowledge.  This
need is particularily important with respect to the advancements that
are needed for AI based security modeling and interdiction.

So our comments are driven by having done a bit of this before.

There has been some dialogue and debate as to whether and how LSM
namespacing should be implemented.  The essential ingredient is the
need to have a task specific context of data, which can be inherited
by subordinate processes, that can be used to evaluate the LSM
security events/hooks that are executed by tasks having access to
that context of data.

Unless we misinterpret the implementation, your patch provides such
context for any process that wishes to unshare any namespace that it
is participating in.

This in turn implies that your patch is a fundamental step forward in
LSM namespacing.  This isn't a criticism, just an observation.

The reason we can feel pretty strongly about this is that we initially
used the same strategy that you are using in a very early
implementation of TSEM.  We abandoned that approach, since the
dynamics/politics of Linux kernel development, particularily in
security, tends to disfavor having to touch core kernel
infrastructure, so we implemented the equivalent of your approach
entirely in the context of our LSM.

To widen the scope of the impact of this, your patch also lays the
framework for implementing LSM specific security policy with kernel
modules.  Again, not a criticism, just an observation, because we
implement the same capability with TSEM.

For those reading along at home.  The reason that this is safe with a
classic namespace approach and not with previous 'loadable LSM'
strategies is that a process can verify that a policy module is loaded
and prepared to handle requests to interpret the events, before the
namespace installation/activation that would drive use of the module
actually takes effect.

Your approach is quite generic, which is positive. The open question
is whether or not the strategy is generic enough to handle LSM's that
may have very dynamic and varied requirements with respect to how to
configure the policy that will be implemented for the namespace.

Hopefully all of this will enable further discussions on this issue.

Best wishes for a productive remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

