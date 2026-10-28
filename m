Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184330;
	b=CQoeZOeFNxQaECTQQGk982rXbLA4DKBVEd2544ruGPSaufkI+NgpqjlBQAfAVuVzMea7
	 u5B1TpVyx5XadBM9Qaa7fX81VreXMGtI8Tv13pJ5u9CBn7UTZSFm80Y4hGVL7FkTL7EBM
	 OG0o0vTkKZ9S88J/l6JAhCuN3r1t3I6UPjlSDPoQz02jIEblJaWAhO99Lj1Q+ayhsYQiS
	 9uYaDpjnxF9+6immWGdt5UEevaVKivm3bLJD9xQPgCp/+EwWaeggOLV9nRcfmyf9rNF4g
	 8McudqqjlGhS1bugcNA1wVsY8E6S6eZPHe5SU1BvxhfQLhW+rNZLiE6eiTNzvKW9gTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184330;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=yH/WNpYHTTuubiG6CEAhex75AWsJRqZOBqYD8LjwIkI=;
	b=RI+8Huko752rs4FzSka4xujuYHhGwFUOqDQUGdJf4bOnPsng17AiM8vHNvc1cRibPcEO
	 QNLOPdMfCu06oreY62nvZfG5MXpOrVQMZrb/rzpW3Wu3ElztsCg92bZNpf0dUFGzpEHBF
	 MYO1tCHvcP+/cPPPvu8kiwCYNXb8qN4WUWul5OL/uIp7pLEujg3paoOfzUeLY6FOMN0fy
	 Y71Y3oo+YggHd1tDMjXrOsMsPtnIzrRDt70i7icn8O4MZrujhwpLedlfn9+Ogu7VXaX4H
	 rdsYrQK44ckVCR1F5F7OVE/ygxI8Ach8IDPhBYAv6TTAJ23v3eweQHG9dnZA9ojM9Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjD1scvA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10824606A31E;
	Wed, 28 Oct 2026 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjD1scvA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486C81F01825;
	Wed, 28 Oct 2026 10:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793184329;
	bh=yH/WNpYHTTuubiG6CEAhex75AWsJRqZOBqYD8LjwIkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LjD1scvAa8fO2U+A2QBBR5ZEe/rqVEBw9RziPliZF2O0uR5lI8qScekDLXMjQzOSH
	 yaXl1PRv26/xXyND+IQ7w8Qw/E2Hw7j5NOQPXbUk17H9aBnv6JU1E2tpo/PYUzkraX
	 KOwTTlIDuc63RRal+eN3Zc9bvQhWDDAOQ5P7vR7YNH/kIDXInENHh+XfyNYSzkNWjl
	 R81XHpY9iERA+P9YRo00zWLvKYDrZJdOwfk1br7DKgbrtXarvoyGUSRWNfpDmMB89g
	 bmsltBAAOQK/2QQyW8uileIJhE5yLi5gSef/Wl86+7ZZc/6s1VraI4N7AdnFZ61E3Q
	 38ytge51EGzfw==
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	netdev@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
Date: Wed, 28 Oct 2026 11:42:19 +0100
Message-ID: <20261028-treiben-probanden-nachkam-e986afed3902@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAHC9VhSJMPOY4X78ENEkAiNeVTCpvP76PgVDqTQfwaYfwnYwAQ@mail.gmail.com>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org> <CAHC9VhR4rMydWiD-RFv-ABiYSG_txJuyrtdaowEXPY=CHEvFXA@mail.gmail.com> <20261027-heckklappe-halbmarathon-vorsorgen-849ffdc42aac@brauner> <CAHC9VhSJMPOY4X78ENEkAiNeVTCpvP76PgVDqTQfwaYfwnYwAQ@mail.gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5627; i=brauner@kernel.org; h=from:subject:message-id; bh=vrGvHxpaFCd2RewEHLR6KXyONZGdNyVnBgFZ5XUewzY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9vNiX9L//hs+Lfwu5Y7g1qj+/OD3Rb2l3qr7Lo8oLW Vf1WO8Zd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEfTsjw9bI6Ae23876c3Mp nJiqWjOr6PP24APzpx0PmP5r17e4eZcYGSYZW0Vev3+ka9Pf00+DomL5Fwh9Y+hjXnrK/FsJ49n 1x7kB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, Oct 27, 2026 at 06:37:43PM -0400, Paul Moore wrote:
> The hooks were merged into the LSM tree on August 31st, and due to
> timing I'm guessing they appeared in linux-next the next day,
> September 1st.  Considering the merge window opened on October
> 18th/19th, that's conservatively a month and a half during which
> testing could have uncovered this issue and the behavior of the hook
> could have been changed to accommodate your use-case.

That's what the rc cycle is for. I'm not asking for changes to behavior
of the hooks to accommodate anything. I'm requesting to make them do
what they were written to do while I was wiring up a consumer.

> I know the
> Landlock folks were testing the hooks for their usage, but I've gone
> back through my inbox and I don't see any reports of BPF LSM failures
> using these new hooks in v7.4 until you posted this patchset during
> the merge window.

Because I sent fixes instead of a bug report. With Fixes: tags, with
reproducers in the commit messages and with tests, before rc1 even
exists. If that's too late to fix a hook that is new this cycle then
nothing can ever be fixed before it's released. Which makes no sense. We
do this all the time.

> The LSM namespace hooks are new to Linux v7.4, they did not exist in
> Linus' tree prior to this merge window which is why I consider both
> the BPF LSM and Landlock usage of these hooks to be "new".

Yes, they're new. That's the argument for fixing them now. Not against
it. No released kernel has these hooks. Once v7.4 is out every one of
these fixes is a behavior change in a released kernel, needs a stable
backport that by your own rules doesn't qualify.

And on top of that nonsense, userspace has to probe for it forever.

> As mentioned previously, I'm pretty consistent about what goes up to
> Linus once the merge window opens: there is the initial pull-request
> with the changes from the last development cycle and then after that
> I'm pretty strict about only serious bugs/panics and regressions.

Your README says "serious problems", not panics. A hook that is
exported to bpf as an attach point and never called is a serious
problem for an API.

And it's not how you've handled this before: lsm_get_self_attr() was new
in v6.8 and got fixed for apparmor and selinux at v6.8-rc7 (cf. [2]).
v7.1-rc5 took Stephen's cred_guard_mutex change for lsm_set_self_attr()
without a crash see (cf. [3]).

> Holding this change for Linux v7.5 will give you and others a chance
> to fully test the new LSM hooks from a BPF LSM perspective, something
> that evidently didn't happen during the Linux v7.4 development cycle.

The series comes with a verifier test and a lifecycle test for exactly
that. Daniel ran it and needs it too. Alexei acked it and asked for the
whole series. There's nothing left that waiting for v7.5 would test.

Nothing in it changes anything for Landlock either.

> Disabling the BPF LSM support for the new hooks in Linux v7.4 should
> be relatively easy, much simpler than this patchset, and eliminate any
> claimed harm.

No. That's a change to kernel/bpf/bpf_lsm.c which you don't maintain
and the people who do have acked the fixes and asked for the whole
series in v7.4.

You're proposing to rip working functionality out of someone else's code
so you don't have to take a three line deletion. namespace_init and
namespace_install work fine for bpf.

It's also not simpler. The LSM part of this series is deleting three
lines I wrote in security.c. The rest is my code and bpf's code with
acks. Your version needs a revert in v7.5 so it's two cross-tree changes
instead of one.

> Also, as the ongoing friction between the LSM and BPF developers was
> brought up, I want to point out that SELinux support for the new LSM
> namespace hooks was delayed to Linux v7.5 due to issues uncovered with
> these new hooks during the Linux v7.4 development cycle (well before
> the merge window opened).

That's not what happened. Stephen posted the fix on September 16, v3 on
September 18. I reviewed it on September 25 and offered to carry it in
the namespace tree for v7.4.

On September 29 you said you'd rather take it through lsm/dev. It's not
in lsm/dev. It's not in v7.4. A reviewed fix that was ready three weeks
before the merge window didn't get applied. That's the same decision
you're making now and it's not a precedent for it.

> I told you "next merge window", which is far from "no".

For v7.4 it is "no". That's the release these hooks go out in. It means
v7.4 ships with a namespace_free hook that never fires and v7.4.y stays
that way because by your own rules the fix doesn't qualify for stable.

> I'll admit to finding it odd that you seem to keep inserting yourself
> into that friction point

A large portion of code where new security functionality is added or
modified all of the time is maintained by me and others. There's
multiple series each cycle that somehow are related to either bpf or the
security layer. What do you expect to happen? That people sit on the
sidelines and write encouraging haikus from time to time while this
friction is grinding any progress to a halt?

Given that I have Acks from both Alexei and Daniel and there's literally
a trivial deletion in kernel/security.c and everything else is in
namespace code, I will send this as part of the first round of vfs fixes
if I have to.

You're objection is noted and I'll mention it to Linus and then he can
decide.

[1]: https://patch.msgid.link/20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org
[2]: https://git.kernel.org/torvalds/c/cf1182944c7c
[3]: https://git.kernel.org/torvalds/c/4a9b16541ad3
