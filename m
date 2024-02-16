Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E401CD3F
	for <linux-security-module@vger.kernel.org>; Fri, 16 Feb 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126860; cv=none; b=t9mTPW8mCznVe/MHAIBZrG476CbiZWc13KuajeDh9sCmkHChAhve40lWmn46uF5DMhKWfR/y8axm/rrIOozLWGIUBwR1svCwOewCFlpkYKDN2PuBwTOlStFcKFk9hVNqWOXPx+pB0lBsCLZSFn31FHtW8pBPGUyhVtItkSeVnGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126860; c=relaxed/simple;
	bh=drn8HTqb9wg7OUd2NKQ+e6wLMgYF0/9bH7KUsWCe2Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMZeNKQkeNQc746RdomPjMFV2BFnBUIyXjK9BJwScK8yuJiUhqFh5xPLLTTtHn9ZZCEasCBPFKWOTPrBny1pcbjPRTXP0Utvjk264S41PxJDD/t9R3erwbqJqAJaFffMHRKhif3yNKTGcoPZNGFcf68RkuPEu/UJG8ClmAso0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 03ACA62F; Fri, 16 Feb 2024 17:31:54 -0600 (CST)
Date: Fri, 16 Feb 2024 17:31:54 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: smack: Possible NULL pointer deref in cred_free hook.
Message-ID: <20240216233154.GA1005338@mail.hallyn.com>
References: <2fa0a73a-1d03-4937-8599-e4560297af3f@schaufler-ca.com>
 <f15e4a73-02e1-4758-a8e6-0edd27224c0a@I-love.SAKURA.ne.jp>
 <757dc423-f914-44b7-98bb-fde5cd42d33b@schaufler-ca.com>
 <b240a8ad-240a-4bc5-9414-62bd417f0b92@schaufler-ca.com>
 <CAHC9VhRdqjWa0Zhw==U=kLNiSeYHDWnQyP8Yb4JNtTA7ki1gqw@mail.gmail.com>
 <8d093ada-995f-4291-9c31-35d9a62525b7@I-love.SAKURA.ne.jp>
 <6e00373a-a028-4575-b2cf-d4da366c2b6f@schaufler-ca.com>
 <CAHC9VhT730AxsUv=1=dEn22ABeHJPZ1JA-xwZv6DN54+DiiKQg@mail.gmail.com>
 <9a816f3b-452e-4d3a-8c45-da49f5461317@schaufler-ca.com>
 <CAHC9VhRK3L12zgzm4-9eyxdhb8Zp-OrAg0UQxFdc3Qdm2yoTKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRK3L12zgzm4-9eyxdhb8Zp-OrAg0UQxFdc3Qdm2yoTKw@mail.gmail.com>

On Thu, Feb 15, 2024 at 10:32:59PM -0500, Paul Moore wrote:
> On Thu, Feb 15, 2024 at 7:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 2/15/2024 3:38 PM, Paul Moore wrote:
> > > On Wed, Feb 14, 2024 at 7:13 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >> On 2/14/2024 2:15 PM, Tetsuo Handa wrote:
> > >>> On 2024/02/15 3:55, Paul Moore wrote:
> > >>>>> Ah, but it turns out that the only LSM that can fail in _cred_prepare()
> > >>>>> is Smack. Even if smack_cred_prepare() fails it will have called
> > >>>>> init_task_smack(), so there isn't *currently* a problem. Should another
> > >>>>> LSM have the possibility of failing in whatever_cred_prepare() this
> > >>>>> could be an issue.
> > >>>> Let's make sure we fix this, even if it isn't a problem with the
> > >>>> current code, it is very possible it could become a problem at some
> > >>>> point in the future and I don't want to see us get surprised by this
> > >>>> then.
> > >>>>
> > >>> Anyone can built-in an out-of-tree LSM where whatever_cred_prepare() fails.
> > >>> An in-tree code that fails if an out-of-tree code (possibly BPF based LSM)
> > >>> is added should be considered as a problem with the current code.
> > >> Agreed. By the way, this isn't just a Smack problem.
> > > I've tried to make this clear on previous issues, but let me say it
> > > again: I don't care what individual LSMs are affected, a bug is a bug
> > > and we need to fix it.
> >
> > Yes, I understand that.
> >
> > >> You get what looks
> > >> like the same failure on an SELinux system if security_prepare_creds() fails
> > >> using the suggested "fault injection". It appears that any failure in
> > >> security_prepare_creds() has the potential to be fatal.
> > > Perhaps I didn't look at the original problem closely enough, but I
> > > believe this should only be an issue with LSMs that register a
> > > cred_free hook that assumes a valid LSM specific credential
> > > initialization.  While SELinux registers a cred_prepare hook, it does
> > > not register a cred_free hook.  Or am I missing something?
> >
> > Yes, you're missing something. If security_prepare_creds() fails prepare_creds()
> > will fail, and the system will lurch to a halt because it can't create a new
> > cred. The cred_free hook is a red herring.
> 
> Okay, my apologies, I thought the issue was due to one of the LSMs
> failing their cred_prepare hook and causing security_cred_free() to be
> called for LSMs that hadn't successfully cred_prepare()'d the new
> creds.
> 
> However, if I'm understanding you correctly, the issue is that a
> failed security_prepare_creds() call can cause both prepare_creds()
> and prepare_kernel_cred() to fail, yes?  If that is the case, can
> someone explain to me why this is a problem?  Both prepare_creds() and
> prepare_kernel_cred() can fail in ways unrelated to the LSM and thus
> callers must be prepared to handle a failure in both prepare_cred()
> functions.

Sure does look that way...
