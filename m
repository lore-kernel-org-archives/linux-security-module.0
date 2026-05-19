Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF2175A62;
	Tue, 19 May 2026 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779150681; cv=none; b=ljPVZBaOHVF84yx7bifvpuPGr/Ixo++U2xgRRjgnm+BpBPeE8ogV+0WgLYF+9nRRBm+T6CbnPv4lwtVURrJ5qxyyVFqUE2gWfbifgrbPlHbS+Sc+RIj5Tio1dG4p4HhLX2/4MWuWlxm+bT3Mme6+NN8FVXirtaQVIcq0VsNpyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779150681; c=relaxed/simple;
	bh=ugd6OYM13lrewg3RCk4+7fzTmJDDbeyPBjaxq5puXrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVg9OZcmORizfr70XSO/6dl355RpJNe4aA83yQPVxH2qlhb35dsJ3O821h7uViBMAXZ9JM2A52HfOHBX4bOiADedWiL6vt4Pib52eHX3/uF7Y2qDISqztBXhjtbhuOFjwAgA5bAjrBShviFF6ja6k482afikTbYuU56aFFSm7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8p4I1CK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8p4I1CK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBB3C2BCB8;
	Tue, 19 May 2026 00:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779150681;
	bh=ugd6OYM13lrewg3RCk4+7fzTmJDDbeyPBjaxq5puXrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8p4I1CKRGuATsYVFUBxxv418bj8L8Be74qaPtvPea3MG6MkN250M3FXNdfeLoiN9
	 EuJkQhvk1vEdmYZ/En+uT2xo6nEhtDl48zDtZTX8RxCeIvwHmJCWU/c7Kn76RYyUiz
	 evDpqldZ59lIB2BC3SQ49+P65rq1jtRa4LXVUFgTZovvMw2hSr/J86xgAybVI73gI1
	 drFqze+7Aib4PVPzcyQyWJgSJKE+Igk58GGKyLwoiJZ8qbISBoEt7pqXgYe2WMx5Fz
	 nNaeErOkSNp0y9yCKwOmHhxtMSYnUtFM0rxyVZSykPHyYfzxo6MsCi7kR0e64KcBP7
	 cI5xevaMAJILw==
Date: Mon, 18 May 2026 20:31:19 -0400
From: Sasha Levin <sashal@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Song Liu <song@kernel.org>, corbet@lwn.net, akpm@linux-foundation.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] killswitch: add per-function short-circuit mitigation
 primitive
Message-ID: <aguvV8QCxK28ZHct@laps>
References: <20260507070547.2268452-1-sashal@kernel.org>
 <CAHC9VhTwDt2Bx8n0io9Qge_fUEnrHsxrFAQY+KaemKWqJqBQxw@mail.gmail.com>
 <CAPhsuW4TJRqQKXgcBYog8YgFLU2h2Zq9ReahxTYp_zpDyvO8AA@mail.gmail.com>
 <CAHC9VhS1DJNs9gDB6gD9WKhL08giSVajBskZ+=mY0AWRCAsw7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHC9VhS1DJNs9gDB6gD9WKhL08giSVajBskZ+=mY0AWRCAsw7Q@mail.gmail.com>

On Mon, May 18, 2026 at 05:29:32PM -0400, Paul Moore wrote:
>From my perspective there are two different issues here: should
>killswitch be a LSM, and should killswitch leverage kprobes to be able
>to "kill" security related symbols.  After all, are we okay with
>killswitch killing capable() and friends?

killswitch doesn't do it on it's own. It may be instructed by root to do that,
at which point that is root's problem.

>In my opinion, making killswitch an LSM is more of a procedural item
>that deals with how we view a capability like killswitch.  I
>personally view killswitch as somewhat similar to Lockdown, which is
>why I made the suggestion.

Maybe I'm not all that familiar with LSMs, but we would need to be able to stop
"random" code paths from executing, and I don't think we can create LSM hooks
at that granularity, no?

>The use of kprobes, while an interesting idea, presents problems as
>allowing any kernel symbol to be killed introduces the potential for
>security regressions.  As a reminder, some LSMs, as well as other
>kernel subsystems, have mechanisms in place to restrict root and/or
>enforce one-way configuration locks; while many people equate "root"
>with full control, in many cases today that is not strictly correct.

killswitch "complies" with lockdown. Is there a different scenario which we
should be blocking?

>Yes, kprobes have been around for some time, this is not a new
>problem, but killswitch makes it far more convenient and accessible to
>do dangerous things with kprobes.  If killswitch makes it past the RFC
>stage without any significant changes to its kill mechanism, we may
>need to start considering more liberal usage of NOKPROBE_SYMBOL()
>which I think would be an unfortunate casualty.

Why? If I don't really mind the security impact, I want to be able to have a
killswitch-like interface on my systems. If an attacker is in my systems,
killswitch is the least of my concerns I think.

If you are security concious, just don't enable CONFIG_KILLSWITCH?

-- 
Thanks,
Sasha
