Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6615CD41;
	Sat,  7 Sep 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725716493; cv=none; b=Mj4fBx9ZHCwgK1d4rFENCEN7eNkKGitTqO7+cJ+WdjKDD1IHmWaMJlIuvpiCLgnWzHmeHpVJN5w6OcOD6TrJwDcFJQrJO9GVIQwYSbaWsmXIMejKwe1iS5wpCt5RXEuRJmSPeZHwTQQwVa6pn+8qU+fg5NvWlATo6iTZC480HYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725716493; c=relaxed/simple;
	bh=yf1Rs+4BL1IQ6seaJ3Oyl+k9Cvz3jHdjfH6+zgZddDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fwwxm22SpNc3AwSvLvWKUB2pk28bQtJaoTv7NSol0vLJuCPyo5hCC3+0gIA2UrGwtUzthqXMNSx7xj80+YHIKLGdmYnpDrR6oU5qphHrDjcgUy4Hq9H7Jyus97fTGuyKywX6UZUVrXwJBqU86NPPLlunV26fpXc7UXEdsoVqNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 487DfOUV089126;
	Sat, 7 Sep 2024 22:41:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sat, 07 Sep 2024 22:41:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 487DfOi0089120
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 7 Sep 2024 22:41:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <efb8f264-f80e-43b2-8ea3-fcc9789520ec@I-love.SAKURA.ne.jp>
Date: Sat, 7 Sep 2024 22:41:19 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LSM: allow loadable kernel module based LSM modules
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, tomoyo-dev-en@lists.osdn.me,
        tomoyo-users-en@lists.osdn.me,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp>
 <CAHC9VhT_eBGJq5viU8R_HVWT=BTcxesWAi3nLcMgG8NfswKesA@mail.gmail.com>
 <d16cd3d1-4b32-487e-b116-419c19941472@I-love.SAKURA.ne.jp>
 <CAHC9VhRdQAoiKMVVUiDyCbEd4EDL9ppH3V4xRGhoOoFmHFy8nQ@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhRdQAoiKMVVUiDyCbEd4EDL9ppH3V4xRGhoOoFmHFy8nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/06 23:24, Paul Moore wrote:
> I've already recorded your NACK on several patches on two of the four
> static call commits, if you like I can add it to the other two please
> let me know and I'll be sure to do that.  I've recorded your NACKs on
> other patches in the past and mentioned those NACKs to Linus when
> sending the pull request, and I will do so again during this upcoming
> merge window.

Adding Nacked-by: lines is not an indulgence for ignoring my concerns.
Commit f3b8788cde61 ("LSM: Identify modules by more than name") is an example
you added Nacked-by: line without adding hints for why I nacked it (e.g.
links to my posts).

  LSM: Identify modules by more than name

  Create a struct lsm_id to contain identifying information about Linux
  Security Modules (LSMs). At inception this contains the name of the
  module and an identifier associated with the security module.  Change
  the security_add_hooks() interface to use this structure.  Change the
  individual modules to maintain their own struct lsm_id and pass it to
  security_add_hooks().

  The values are for LSM identifiers are defined in a new UAPI
  header file linux/lsm.h. Each existing LSM has been updated to
  include it's LSMID in the lsm_id.

  The LSM ID values are sequential, with the oldest module
  LSM_ID_CAPABILITY being the lowest value and the existing modules
  numbered in the order they were included in the main line kernel.
  This is an arbitrary convention for assigning the values, but
  none better presents itself. The value 0 is defined as being invalid.
  The values 1-99 are reserved for any special case uses which may
  arise in the future. This may include attributes of the LSM
  infrastructure itself, possibly related to namespacing or network
  attribute management. A special range is identified for such attributes
  to help reduce confusion for developers unfamiliar with LSMs.

  LSM attribute values are defined for the attributes presented by
  modules that are available today. As with the LSM IDs, The value 0
  is defined as being invalid. The values 1-99 are reserved for any
  special case uses which may arise in the future.

How can people (or Linus) find why I nacked it from patch description of that commit?
The reason is partially explained in commit 063a7ce32ddc ("Merge tag 'lsm-pr-20240105'
of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm"), but is not accurate.

  - Add three new syscalls: lsm_list_modules(), lsm_get_self_attr(), and
    lsm_set_self_attr().

    The first syscall simply lists the LSMs enabled, while the second and
    third get and set the current process' LSM attributes. Yes, these
    syscalls may provide similar functionality to what can be found under
    /proc or /sys, but they were designed to support multiple,
    simultaneaous (stacked) LSMs from the start as opposed to the current
    /proc based solutions which were created at a time when only one LSM
    was allowed to be active at a given time.

    We have spent considerable time discussing ways to extend the
    existing /proc interfaces to support multiple, simultaneaous LSMs and
    even our best ideas have been far too ugly to support as a kernel
    API; after +20 years in the kernel, I felt the LSM layer had
    established itself enough to justify a handful of syscalls.

    Support amongst the individual LSM developers has been nearly
    unanimous, with a single objection coming from Tetsuo (TOMOYO) as he
    is worried that the LSM_ID_XXX token concept will make it more
    difficult for out-of-tree LSMs to survive. Several members of the LSM
    community have demonstrated the ability for out-of-tree LSMs to
    continue to exist by picking high/unused LSM_ID values as well as
    pointing out that many kernel APIs rely on integer identifiers, e.g.
    syscalls (!), but unfortunately Tetsuo's objections remain.

    My personal opinion is that while I have no interest in penalizing
    out-of-tree LSMs, I'm not going to penalize in-tree development to
    support out-of-tree development, and I view this as a necessary step
    forward to support the push for expanded LSM stacking and reduce our
    reliance on /proc and /sys which has occassionally been problematic
    for some container users. Finally, we have included the linux-api
    folks on (all?) recent revisions of the patchset and addressed all of
    their concerns.

I am not against about having LSM ID itself. I am against about the fact
that out-of-tree LSM modules cannot have stable LSM ID. Commit f3b8788cde61
wants to assign LSM ID sequentially whereas those who demonstrated me
suggests assigning LSM ID non-sequentially and pushes the burden of
managing collision to out-of-tree LSM modules. As a result, out-of-tree
LSM modules cannot start using userspace tools which rely on LSM ID.
Rewriting userspace tools when that out-of-tree LSM module succeeded
becoming in-tree is a penalty, for it breaks existing userspace tools
and also remains the risk of old LSM ID being reused by unrelated LSM
module.

The fact that out-of-tree LSM modules cannot have stable LSM ID penalizes
out-of-tree LSMs due to the risk of collision, and making it difficult for
Linux users to find LSMs they want because Linux users cannot know what
LSMs are available in the world. That is not a good usage of identifiers.

I suggested you that the LSM community should allow assigning stable LSM ID
to any LSM as long as that LSM is available to anybody, and serve as index
for helping people to find LSMs that match their needs.

Paul, where did you explain above when you sent pull request to Linus?
Linus, did you understand why I nacked it from that pull request from Paul?

