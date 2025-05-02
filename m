Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624AD1EDA36
	for <linux-security-module@vger.kernel.org>; Fri,  2 May 2025 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216089; cv=none; b=mGzg6mpYdQcRd5SMzaMfv69SCEynFBA6br7emIUx5Ip8iiKHaVerhCB/4W3jc8t8ns9uPxjFa5dgyzT4OeBa0ab4uLXTL+b4ECn2nUT8uZxSlx0m5NY/Fx5sOnkimglNROsUV8oj+AD6NfigCo9AgmYRmYXUnX2I9CtnqWZIueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216089; c=relaxed/simple;
	bh=WW4QBF9emqCbjC/9TvFh+whwW8ygos3aFSvz7vwhoOE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aWT8XCKbf7GFXRMPrdGDJnFpzxqhMGYSuUmamNLqZgi46L9QCP2FnOuX+IfXATsEzZtqS2gc7ocKpNqht0RmjNCQbbZkHeKtVbNK896EIQ0TuMD8dpYyq2M/t4eHJpIb4n/DXzBitIlqBKF1XkqOXoHrdSe4nbOEJS44wggK1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZIEMNJoe; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZIEMNJoe"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-708a853c362so22275777b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 02 May 2025 13:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746216086; x=1746820886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n8WxfjP4ZaeLalbK3fLwOxfZfNYUH8QwQTJ3Di2jk38=;
        b=ZIEMNJoeTXv8y6evobpYhZoxRC1DpNcoh3x3Fj2Ki8LDTEfk6Bk1J/juStYyU6vuFg
         mMGSZX1FSd3jH3yx0k0sp+7e6wdKEpQXoR/qztNmYm+pimA92VCB5NGYy+BJjU23QyRw
         AbW3gmJoIkGEyI3shq4/G7PXa0VmQ9eZUD6btxHrkOgT3K17XSEIkFNP5F1CZ0K3c2zT
         ZcQWNY6kXOobJ2B8ZS5hShe48/9Hg9VoCbj/82gXx4cx9V6tuSuJ7WrqATBmukyDrDUn
         vMLuwUZBhyfGYLNblkEWgjy8t3yEYsIL9/6+vPfzjJOIMLDJPUgZKo+ZwpayTgThg87E
         1jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746216086; x=1746820886;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8WxfjP4ZaeLalbK3fLwOxfZfNYUH8QwQTJ3Di2jk38=;
        b=WPHm5DXm7x1qv6KFLiG9sXoUO17khPFAUZFb+b1ZqvHBnWO210wxNHzPlLCI90fro/
         VgGTVGRCtHOezKiMXT/eh096jZjbR9sRBED4gz9x+mAZwa8gLZcVfKC7ec301GzgxGph
         xQw/e7CxeyzO+g4YZhjOMMPa7Uzt0ZribXjpCKIS0D+iagAGoSS9DlV6D9ZbBIulUj4z
         9m2jmSDJenIP6oHDhVcZYOnMNwnWoNmpc6ywtOQXf6EflTL2CYNoHAu3nG6HKswY0Zd1
         7TuRYNRScM+I9uyEaiSmLaboHd3zTwo5i98gD+APG4RjBMGjObkjm30LVXIRVyKO1AUe
         sIVQ==
X-Gm-Message-State: AOJu0YzqERor6QkWpfawpaEsxlWa23aiQgsPuzz4EeCltecRvzHe6K7H
	wYwpD1K/L6+aKJRk3/St/428IjLld22kF3mIDqW91bbV3r/dCeEykqJ8B4oi3FmdtqeCKpD2bjG
	/2HL9brArg4P8RotF2vSgzBRN3Jtxx86rhp1ETTQKxrbkTk9Mvg==
X-Gm-Gg: ASbGncurg1qJkRoSJABCmkLEWNEsoVgZ6pP8D3DC0zlBK1sVbnmXMG2Nsh66UTKmuE8
	EddDNC6sS3sHwsgxjXwLMUcR7c18++HS+aQuevjX0MZ04U/Z+YHVE6eFb8dBPgG+JwbQOEszMWB
	09Q9VaU/77253QZLu9vObymKC/baUy127f
X-Google-Smtp-Source: AGHT+IGMwSX7aivvBH5ul2umgktm6ZAtPEGmJ50BO8uKiy2xL2i26TXI3LroKLihR/8h3PdU9WTtF/RNBSBIxJ8k7kE=
X-Received: by 2002:a05:690c:c8f:b0:703:aea2:6bb8 with SMTP id
 00721157ae682-708e134b8e7mr5695347b3.28.1746216085964; Fri, 02 May 2025
 13:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 May 2025 16:01:15 -0400
X-Gm-Features: ATxdqUGye2YKuzXF58NoryrgYICcidOmHQOofcQT8vMN7xWPT2azCLHCfVoZric
Message-ID: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
Subject: [RFC] LSM deprecation / removal policies
To: linux-security-module@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Fan Wu <wufan@linux.microsoft.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hello all,

We've worked in the past to document some of our policies and
guidelines, the result can be seen at the link below (also listed in
MAINTAINERS):

- https://github.com/LinuxSecurityModule/kernel/blob/main/README.md

However, one of the areas that has been missing from this guidance,
are policies on deprecating and removing LSM hooks as well as LSMs
themselves.  In an effort to fix that, I've drafted two additional
sections (below) and I would appreciate feedback from the LSM
community as a whole on these sections.  The LSM hook deprecation
policy follows the undocumented process we've typically followed, and
while we've never deprecated/removed a LSM, I believe the guidance
documented here follows existing precedence.

## Removing LSM Hooks

If a LSM hook is no longer used by any in-kernel LSMs, there is no ongoing work
in progress involving the hook, and no expectation of future work that will use
the hook, the LSM community may consider removal of the LSM hook.  The decision
to ultimately remove the LSM hook should balance ongoing maintenance and
performance concerns with the social challenges of reintroducing the hook if
it is needed at a later date.

## Removing LSMs

If a LSM has not been actively maintained for a period of time such that it is
becoming a maintenance burden for other developers, or there are serious
concerns about the LSM's ability to deliver on its stated purpose, the LSM
community may consider deprecating and ultimately removing the LSM from the
Linux kernel.  However, before considering deprecation, the LSM community
should make every reasonable effort to find a suitable maintainer for the LSM
while also surveying the major Linux distributions to better understand the
impact a deprecation would have on the downstream distro/user experience.  If
deprecation remains the only viable option, the following process should be
used as a starting point for deprecating the LSM:

* The LSM's Kconfig description should indicate that the LSM is being
deprecated and the LSM should not be built into the kernel by default.

* Entries in Documentation/API/obsolete should be created for any user visible
interfaces associated with the LSM.

* When the LSM is enabled at boot or runtime, it should display a message on
the console that it is now deprecated and will be removed at some point in the
future.  While the message should be displayed without delaying the boot at
first, after one or two kernel releases it may be helpful to add a small,
e.g. five second, delay after displaying the message to draw attention to the
deprecation notice.  The delay can be increased in successive kernel releases
until it reaches a level than any reasonable user wouldn't be able to ignore,
e.g. 30 seconds.

* Finally, after an additional two to three kernel releases, after any
deadlines listed in the Documentation/API/obsolete entries, and once the LSM
community is satisfied that all users running modern kernels have migrated away
from the LSM, the LSM can be removed from the Linux kernel and any entries in
Documentation/API/obsolete can be moved to Documentation/API/removed.

It is important to note that the steps above are intended as basic guidance for
a generic LSM; it is likely that changes, including additional actions, will be
needed for individual LSMs based on their design, implementation, and
downstream usage.  The LSM community should take the process above as input,
but ultimately the process should be tailored to the LSM being deprecated and
the associated environment.

[SIDE NOTE: I'm trying to close out the outstanding TODO items for
this document in preparation for moving into the upstream
Documentation/ directory, there are a few small items remaining, but
the deprecation/removal guidance is the largest.]

-- 
paul-moore.com
