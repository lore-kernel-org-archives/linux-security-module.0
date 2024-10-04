Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3DB231CBD
	for <linux-security-module@vger.kernel.org>; Fri,  4 Oct 2024 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075268; cv=none; b=DjSxYDHMPcqBeyuTgsQMxcL3+bkpEZxw1uMogBwUwUuXZGD/qUVKRyKTTnvWgvzEP/wuNTJ2+ZOrfyAVzxsOVARmWezbgB1W/SGOyvbIKoDpJA5GdJLxJGUsGxhS5PhcQVtrG8obfgs6krBjlCG4mPwQbKjziuFRrZi2KECWOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075268; c=relaxed/simple;
	bh=gZxmJqGIdXGzm/fuDEMNmxlg4uCYkUXs4DGn+1MadY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS9P1CqFovheVAnOybB65gPicgsnQJZa7SYheqepX1LuFGQyCQUxQObzluNjVGKCY97wk0YCP6Ghm4BFt+mvFJwox0Q+S5vug0BQNsNGhPirN8o2d0gIuKxAayrY9/xHHPOdiZW92ubhyhUW3mYZMXg4wXY5P1rF72PBSVOwHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW7hQsnB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW7hQsnB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49DEC4CEC6;
	Fri,  4 Oct 2024 20:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728075267;
	bh=gZxmJqGIdXGzm/fuDEMNmxlg4uCYkUXs4DGn+1MadY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HW7hQsnBpkYGMaCPjFEBLFQr0u81HiCFYMftrDl8ur59BoFDe1B9GJPFO9qX8XJ2N
	 6nNpt8CmLBgZBRAX2iXLDhQb7QS4cgbel+4DBjHOag7O0b+GzE5McNz5yKHnTurEq1
	 G1nsxzbdBPNlFXs0vQBbcIMXZ/O9PA7UF2vf700Q7jqIwIf+ySKNq3FdqujQhfLHmk
	 CNHwCk+rSzjc+rtqevDhqU8lzKiZsekolgcFOtZvkaYtR0B+wI6DbZfe5f+f10GpXd
	 utcscvq4wq9CjtplSOOXpfbdP6mJnBsQrfeYdSbMpCD0zS2wtK6q8CUOj68jRXjnH8
	 lOjNNzUXwdr4Q==
Date: Fri, 4 Oct 2024 13:54:24 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Fan Wu <wufan@linux.microsoft.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	KP Singh <kpsingh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-security-module@vger.kernel.org
Subject: Re: TOMOYO's pull request for v6.12
Message-ID: <202410041305.544EA7E4E@keescook>
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>

On Wed, Oct 02, 2024 at 04:12:50PM -0400, Paul Moore wrote:
> As I wrote in my original response to this pull request, this is not
> something I would accept in a new LSM submission and thus I feel
> compelled to speak out against this change and submit a revert to
> Linus.

The patch should be reverted regardless of the LSM specifics:

- The patch is (extremely) non-trivial and:

  - was never posted to any mailing list, which means there was no
    opportunity for discussion

  - did not appear in linux-next, which means there was no opportunity
    for any integration or similar testing

- The patch provides new symbol exports without any discussion nor buy-in
  from the symbol owners. (I do appreciate that it was written to be
  extremely narrowly scoped, but it doesn't matter: it's new exports.)

Given the social history of the code in question, I think the patch
should be reverted due to its _intent_. The above items do not look like
accidents nor oversights, but rather an explicit attempt to bypass the
normal consensus-based development practices of Linux itself.

It's also a red flag that the code was written 6 days before the merge
window -- even if there HAD been discussion, that is an extremely narrow
time frame to propose it for a pull request.

Speaking to the implementation, it's a clever use of static calls, but:

- it internalizes features that were designed to be commonly implemented
  and NOT used internally by an LSM.

- tomoyo_register_hooks() becomes an exploitation gadget that could be
  used to bypass the LSM as a whole.

The first issue is more of a code pattern and best practices issue. The
latter is the core problem I personally have with the implementation:
LSMs are one of the first targets during memory corruption attacks,
so we've tried to reduce their attack surface very aggressively. That
generally translates into making any function pointers (or associated
tables, manipulation routines, etc) read-only.

That this patch would result in TOMOYO getting enabled on RedHat seems
extraordinarily unlikely as RH went out of its way to remove from upstream
the very last part of SELinux that might provide this kind of read-only
bypass: CONFIG_SECURITY_WRITABLE_HOOKS. See f22f9aaf6c3d ("selinux:
remove the runtime disable functionality").

So, no, I think this endangers the other LSMs, has not been discussed
with any other parties, and has likely no path forward in RedHat.

It may be possible to change RH's mind about enabling TOMOYO, though, as
it was denied[1] almost 13 years ago and MUCH has changed since then. A
good place to start would be a new bug report, which has happened[2],
but has yet to be triaged and was only opened 2 months ago. I would
recommend reaching out to the RH kernel team directly...

-Kees

[1] https://bugzilla.redhat.com/show_bug.cgi?id=542986#c8
[2] https://bugzilla.redhat.com/show_bug.cgi?id=2303689

-- 
Kees Cook
