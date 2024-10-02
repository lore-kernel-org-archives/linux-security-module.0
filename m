Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21231D0E28
	for <linux-security-module@vger.kernel.org>; Wed,  2 Oct 2024 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899983; cv=none; b=ksLq9iWhaXahR6fruKJAcYIqu6+83B8J5bReCPvBrbqIzW9PKtEz3dQ1XevzTiDwTArht4huJ54l/E3a1CnZeBVP/20NTscPHZb3RGuLKHrtU7HsLEOh3ML3AaT27elzl4UCwJtGB0OwCy7Jpl4EJrTqygEgBCKw9Fh8xvh/BTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899983; c=relaxed/simple;
	bh=qSDeH5UQeXxu7PV1fzijx6ogEZx+M75JGHx1QyRA6jY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=g6HqaqCOM45BpHZo/N571BS86ZvX4ynuUnnoYcmWecdQihcVtJh5KdWoR5G3Fl3kHgMBHBODIUDrXfcpv37X2nI39IL/eW5e4Y0/H6w8+V4ePC2U4j4hhRQwmj9qD8cvgzFw47hfAmZq5mewpOjPlOGR66riNtSmkb1ARCu7EDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G3ign9rk; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G3ign9rk"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e2772f7df9so1867577b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 02 Oct 2024 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727899981; x=1728504781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NkHB0t8b+RZTi1zmcdXqTMhYvXoX2NP46jx4wb/9noM=;
        b=G3ign9rkQUicy6d1Dh17fdtvTZ85dkGs2qCILtHn2hIkOMdVAVSCI96vM42J8+zbGi
         0aO90vFRxy7o3a9KL0KH7pnFBliTmwQnT+vlTH7kH77U/wOATkBMuQJDG4aiM0AkWMkd
         +rRm9ESUdVlZlGa3cGfyXJAQMaZ4RL33xHpThIJ88tj5vHiDODXwYP8iT6nlb2BKs/f3
         LnESgbtShhXwWOmCLCvJ3uPINIgr+EsYAL3qlVdWIqTPUvnIwfTxCyddxjA2qc4dSzda
         ISfs2xqfY1wvGM3BM+cUIEiAVIrEJWTFI7J9Deyh6JUzvprweO04GOP8PAMlnU1gxMBZ
         tZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899981; x=1728504781;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkHB0t8b+RZTi1zmcdXqTMhYvXoX2NP46jx4wb/9noM=;
        b=nb9/RgV17Qc0/IBoxcH4tKMy6vUzxpnBA3WsgbfelwuA1a9iqS1qFw1BsJTOqop89o
         HTkRcsMgUZCQ9Hl/nrzj3qBjfOeqsVr9I4BtfHSVeD+jbfx3ma1Y5HFIWFR9McOqiF6Y
         1Ya3TJDZEDHLbWiJDVdZ3RUoJtd1o8QI3JFvE0qv1/mxNFemUVbmxs0+J6F9MR13aUpG
         tEYkao8Td5okzA7+iqL5yQdkTOgp50zWRt6pfaFpgcCBpRTPMoAeU7+WpRNAPm7TeKHh
         hX8vYdnMbhPc0up/i4NPJWqWElf5apwVnChQidFmtaqV57qt6judbXVVCHi8gcevKXao
         JGOA==
X-Forwarded-Encrypted: i=1; AJvYcCW0sUqG0epjlFLmixaWP0FxnyjP+6P4+oS5k+bgCCPhZXUFU5QIk/YBzQw0Szs67DNLPnnC8pHfKhsE7k61FBfRYn1g2M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzguYsGY0Kt17qsnu3ph+22j1Owpwg8LiA1hrA+j8DMXYAGOFaY
	v1BfPjp64HyFkw8rZhiw7CUMeI65WHtv+OHdWBBb3hllLqU3/yHzAvP9BsG2kXUL0dqrNSRMCUC
	CMgKR/kExtjMk2PLnbI5n/upaDlsrdzTeu+uj
X-Google-Smtp-Source: AGHT+IHoJclEqaqmru8zzMyUY+5MIh6vx0p0VzLpsRor9KtXV0vSPlg3NtqUzsA1l3jqH7VxKZgs0QAFSl7XOwcao70=
X-Received: by 2002:a05:690c:340f:b0:6dd:bfde:7108 with SMTP id
 00721157ae682-6e2a2ae07a0mr30654867b3.5.1727899980763; Wed, 02 Oct 2024
 13:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Oct 2024 16:12:50 -0400
Message-ID: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
Subject: TOMOYO's pull request for v6.12
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Fan Wu <wufan@linux.microsoft.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

Hopefully by now you've at least seen the TOMOYO v6.12 pull request
thread; if you haven't read it yet, I suggest you do so before reading
the rest of this mail:

https://lore.kernel.org/all/0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp

Of the three commits in the pull request, the commit which concerns me
the most is 8b985bbfabbe ("tomoyo: allow building as a loadable LSM
module").  The commit worries me as it brings management of the TOMOYO
LSM callbacks into TOMOYO itself, overriding the LSM framework.
Jonathan raises a similar point, although his issue is more focused on
the symbol export approach itself, rather than conceptual issues
relating to the LSM framework.  I will admit there are some high level
similarities to this approach and the BPF LSM, but I believe we can
say that the BPF LSM exception is necessary due to the nature of BPF,
and not something we want to see duplicated outside of that one
special case.

As I wrote in my original response to this pull request, this is not
something I would accept in a new LSM submission and thus I feel
compelled to speak out against this change and submit a revert to
Linus.  However, as the LSM framework exists to satisfy the needs of
the individual LSMs, I've tried to ensure that significant changes
like these are done with support of the majority of LSMs.  I
understand that in a case like this, reverting LSM-specific commits,
individual LSM maintainers may not want to speak up on the issue so
I'm going to let this message sit on-list until Friday morning, unless
I see the majority of the LSMs voicing support *against* reverting the
TOMOYO commit above (and the other related commit) I will proceed with
submitting the revert to Linus on Friday.  I would prefer if all
responses are sent on-list, but you can also mail me privately with
your objection to the revert and I will include it in the count.

Thanks.

-- 
paul-moore.com
