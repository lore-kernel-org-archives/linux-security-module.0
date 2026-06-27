Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22791991CB
	for <linux-security-module@vger.kernel.org>; Sat, 27 Jun 2026 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782539042; cv=none; b=IwCvBwD8YBJRwcwmEU4zemXqpRKr+oxa0UNfJX2lNVGuTACoDWgYz43/OQRo56mwkr5WHBhRrQWguVjXoCr/N7rqQfEMdjoWSpjhSFOEKJ9FfwyamRZrhbGh91n7NFH3FYnLwIRz8dKPmumKx3vaap/58lhipypGDL582GPZ9Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782539042; c=relaxed/simple;
	bh=jzwh6N4rB4bxLsLJ/HacSJuKadslqDEmpW/tplmavw8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=s4HXdfrBOeqaPMF6+Dhel4HAZodJ8tyKKPz5KJVG0G6H/+v5ObXlowNqQSE+zLNvTpkBLXeuczzbRfoFYqvsrvR8+sQS2ngmwk9tiYY4rSOnPZoqzZm8KAMry/gEI2vQKAnG2cpdPvPwhB0YxNXJCtjbigkgLlFocwOsYOitF0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e9b71bdf0aso575137a34.3
        for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2026 22:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782539040; x=1783143840;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv9j60t3Avv9jlw5K05gGOYRTpSMIX71ul9kgeDl4nE=;
        b=IIB7xazHe6Q5WuPupYZmygomSzZyjuoHHgKz7+QH0uHyz39KQ82ptyXYrudeXtn1IU
         XcOzgekcGR3okRQUQePoEvA/91jfCyMGD5W42WVq/ogqfNDmqev9FInjYQvJyoddqtgw
         wAAXfVs9U8zI71vwDVBEe66rf6LIyLexKGXg8bkfInSdHuOHkClPC6hbONq7QYdvwz9x
         b8gKqu4BDindWCI/5KnnU7gaJH6z/AHbI+sAzcAnA/AB0wm97H5q9ZHCwOuiJvyiLrfQ
         NyMNn4tfPWnBx8kG8Cok22h0vwi4llyzqCZOkwSS4qLe1twqbDS55NC4dPZfBRBqCg0K
         IUaA==
X-Forwarded-Encrypted: i=1; AFNElJ+8e5Log7QkpJIvhmlLBYiIuyUcpoSefMwXnmcdqqjBghQtJkulDBk3wLf3HdwqL+DbjpOWpmjcFI5sGn8/S11+poKw8d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwyJp/x3p/q+SzOzKitiTdSWEzhoqblnMDrRurHe6XJSF0dwcm
	Y9uZWCujDhZLS6tNd65aUTcT27B6pzLBu0DVs9CJdOR1kF6TTTo/IfERUuHZRjKM4tR9f5jCHe/
	uHgVW3JVHl+Ci3vlvTq5wGbheMaT65qcVJJpNNCjeXaa6Bbx70S0lPqEhNwc=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6411:b0:48f:a9f3:1c38 with SMTP id
 5614622812f47-49216e3555amr7704047b6e.2.1782539040059; Fri, 26 Jun 2026
 22:44:00 -0700 (PDT)
Date: Fri, 26 Jun 2026 22:44:00 -0700
In-Reply-To: <790d4d56-4c24-4468-b588-722e6aa86ba1@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3f6320.ac7367b4.6675.000a.GAE@google.com>
Subject: Re: [syzbot] [tomoyo?] KMSAN: uninit-value in tomoyo_path_chown (3)
From: syzbot <syzbot+eaae8fa60ce81f1e4eeb@syzkaller.appspotmail.com>
To: penguin-kernel@i-love.sakura.ne.jp
Cc: jmorris@namei.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, penguin-kernel@i-love.sakura.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"

> On 2026/06/17 17:41, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    2b414a95b8f7 Merge tag 's390-7.1-5' of git://git.kernel.or..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12cff156580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=a0ca3b8cb3875012
>> dashboard link: https://syzkaller.appspot.com/bug?extid=eaae8fa60ce81f1e4eeb
>> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>
> The AI's analysis
>
>   In this case, `chown_common()` skips setting `newattrs.ia_vfsuid` and `newattrs.ia_vfsgid`.
>
> at https://syzkaller.appspot.com/ai_job?id=abea5dd9-2a6e-4669-a927-d87ef7833666 is wrong.
> We always set newattrs.ia_vfsuid and newattrs.ia_vfsgid before checking for -1.
>
>   retry_deleg:
>   	newattrs.ia_vfsuid = INVALID_VFSUID;
>   	newattrs.ia_vfsgid = INVALID_VFSGID;
>   	newattrs.ia_valid =  ATTR_CTIME;
>   	if ((user != (uid_t)-1) && !setattr_vfsuid(&newattrs, uid))
>   		return -EINVAL;
>   	if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
>   		return -EINVAL;
>
> Therefore, unless VFS people find something that can cause this problem,
> this would be a random memory corruption which confused KMSAN.
>
> #syz set subsystems: unclassified
>
> #syz set no-reminders
>

Command #1:
The specified label value is incorrect.
"unclassified" is not among the allowed values.
Please use one of the supported label values.

The following labels are suported:
actionable, missing-backport, no-reminders, prio: {low, normal, high}, subsystems: {..
see below ..}
The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems?all=true

