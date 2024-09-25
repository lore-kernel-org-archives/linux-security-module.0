Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83BE175D37;
	Wed, 25 Sep 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264234; cv=none; b=iI5Y1y8WjD1AwjhREIJ6ND11zgrDKHE+4D0yMKHL5+H5ptltlBrLCzhFyKuJdo0CqYW62MQEPMXIfJtTl7SxPVTfmp9dpg5UevWd2ZbI60dCMgzKx0w0YgLh0gPgyE3V6i15SlXYJYDXnkGrnoH10VPm87aVZw5T04C7GBrij9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264234; c=relaxed/simple;
	bh=7Dve7AlWC4FeBvaR1mefkGri4yYyskMUqoxhoVI9PZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1W1Xvk3BwFYf+SYTzemVvNSzgJf0Bv7FTP7lIUpQZHuyd6Jqch60Eo4O3LEpnRiSu4kxSlqJ8A8DeQVIk2R69BitD8lx1dkUcWZ1vuIV19ss3Eexli4J+gCTSN7VAlzinj6NAiiroQ2GJp2LC9tQlUYJ2HFnfDr39GWlNzOfNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jifn3Vh/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jifn3Vh/"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-537a399e06dso4136836e87.1;
        Wed, 25 Sep 2024 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727264231; x=1727869031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M2c4QkqUSunQnHqhEYmc9PBGDMAL9urYEXHH5gg9oUE=;
        b=jifn3Vh//p3T0L5e4osZpVPMwKeK0u24ztLc4sfEpP894i5eYiN9D/zhOSKFeVfQYP
         iXdklKlIAwzeDgQknGmxroUPwQKJhRSsdY2+Iv4Wm9wj7R6/zZMhJ7ufygW8LzOH40dV
         OpyDw/NbayHyECxt02LY0hiD/+I8cUbXQ1QmHn9Yfy6NugY5YlDU6FiGOQlX26lslzEu
         IcEEHBmem4IDTPqIquqzCgqjtW6/45dxCV474aidsaJwUDYOJQcTkTR0e1kNVIIznQF4
         5YilsOtDENiyMLcyShofBj5gcnzwE34t9f2hQwG2QipGCxMtsN1Sz7N3YzTTKWaZF4zk
         hZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727264231; x=1727869031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2c4QkqUSunQnHqhEYmc9PBGDMAL9urYEXHH5gg9oUE=;
        b=uYJYtUyaxLofDieA5IKZQF6F7vTR5PCYjUadp42n8JkCGbXF1LF7wgrqIkAU5/3+bW
         M6+9KvE3JM4ZqbQTqckypZ3sUtAXllOwPuzBwF5F9toHchh01bEef+HFPjFV+B5GZU+V
         t0cJhZahgNkzZO2X5I8zvkO5fI5zcz8/0NwWvvwinlYgqACPQmhIhGr25/y185d8RAPl
         OcOqSGiK8P0+qfKf/GG1lUVNRKYtDJeKA3QFYtdf3iDwmQBJuLaWZ7uSyo9FEu4N9+Zw
         RCfjHav+MI9aLvs+JRRCiOzS410rYr+zHj2IYh+xCQSej8rZ/VNiBEQYB6qXk9mC14pM
         KXNg==
X-Forwarded-Encrypted: i=1; AJvYcCWQggSNxofWONQa0dPWDqDO6NnDYNpHAIxt0aIruTv+l9fuXEdVl39cBKG90s0WgrzAp0wdBjtlmwTjrAc=@vger.kernel.org, AJvYcCX/xZLYffODbb2W/3x3tAsYDT9U+rAHjoIt1iZLAVc1jPX/i3TYFUTuJTrwMP0ACZqTH/K6Rw3M66M7Bif8UHVs9RUrTeRO@vger.kernel.org
X-Gm-Message-State: AOJu0YzEToJX3ANRPMZHfDOfKlJiok6xhVP6vas0cMa44lZDKQeQALSn
	f0teljqL5AEoMUZt9g1kE+pat+sRC6SgnBndpIj04g4ZqLIC1nxCDmLvkHio2YXtYaCtgFqynFR
	FkTCULMmEw15jICypLF13fkC4IYg=
X-Google-Smtp-Source: AGHT+IHYrPcfkliD+Hijl1J7liKGDqIM1On5CGTajvpqJdM+yKtElYu1h+7Y/NbqHMu3+t5CBuXW2otvJhFl3+q/9Mk=
X-Received: by 2002:a05:6512:68c:b0:535:6965:be30 with SMTP id
 2adb3069b0e04-5387756722fmr1303526e87.50.1727264230308; Wed, 25 Sep 2024
 04:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925063034.169-1-ebpqwerty472123@gmail.com>
 <72050879-4546-4bc7-9983-79ad437594d4@lucifer.local> <CAHQche8ijvNfKHBLV8BWWq85rjKQbjO+0w2s6kj4V3OpBANcuA@mail.gmail.com>
 <78a854db-e8ea-475c-950d-2d9faf72f2b4@lucifer.local>
In-Reply-To: <78a854db-e8ea-475c-950d-2d9faf72f2b4@lucifer.local>
From: Shu Han <ebpqwerty472123@gmail.com>
Date: Wed, 25 Sep 2024 19:36:59 +0800
Message-ID: <CAHQche_92iaqxWK7WKDnEDkCRV-r2HXL2xuRa7b2NBaLhUg7-Q@mail.gmail.com>
Subject: Re: [PATCH] mm: move the check of READ_IMPLIES_EXEC out of do_mmap()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, Liam.Howlett@oracle.com, vbabka@suse.cz, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

> No need to be sorry! :) Sorry if I sound harsh here - it's more a case of
> trying to be as clear as I can be as that is the best approach for everyone
> I think.

> This code is sensitive, so we have to super careful!

Thanks a lot! :)

> I would disagree it's down to taste, I noted on the move the check to
> do_mmap() series a number of issues and concerns, to me that seems
> unworkable in it's current form, the locking thing is fatal for instance.

> What you link to there seems to be neither approach (I didn't read your
> second series though as that needs an RFC tag)? I mean I think perhaps what
> you are doing there is the best _first step_ - simply add the checks in
> each of the callsites that you feel are missing them.

> This is the least controversial way and then allows maintainers of the
> callers to assess whether they intended for that.

> If then you end up wtih _all_ callers doing this check, we can take another
> look at possibly bringing it into do_mmap() but we would absolutely have to
> ensure it was done correctly, however.

> 1. (If you haven't already) Submit a series that adds patches to add checks
>    at call sites that don't already check.

> 2. If these are accepted at _all_ callsites, revisit the do_mmap() change,
>    properly accounting for locks (I can help with this).

In fact, "mm: move the check of READ_IMPLIES_EXEC out of do_mmap()" does
not have the locking issue. These two patches are quite different. This is
also the modification I recommended, while another modification was
suggested by LSM maintainers(Perhaps I need to add suggested-by? But
that was mentioned in a non-public security mailing list, and I'm not sure
if it's appropriate.).

The __core__ problem is "no LSM hook" +
"have logic about READ_IMPLIES_EXEC". Removing one of them is OK.

The "mm: move security_file_mmap() back into do_mmap()" fixes this by
adding a LSM hook. The requirement to call LSM hooks comes from the
LSM modules, _not these call sites_. The issue for locks also comes
from the specific implementation of LSM modules. So I send patches
to LSM maintainers at the same time.

The "mm: move the check of READ_IMPLIES_EXEC out of do_mmap()" fixes this
by removing the logic about READ_IMPLIES_EXEC that is not needed. So no
locking issues there(no changes to LSM). This will result in some minor
behavioral changes for call sites mentioned in the patch. Unfortunately,
due to this logic being placed in a single function do_mmap now, it is
impossible to confirm it through patches one by one before change the mm
module. Fortunately, these changes should clearly be fine, and here are
the reasons(more specific versions):

fs/aio.c, mm/util.c, ipc/shm.c: no changes
arch/x86/kernel/shstk.c: Shadow Stack is stack only store return
addresses, adding execute permission to shadow stack is never
required.
mm/mmap.c: in the history, remap_file_pages won't care about the
READ_IMPLIES_EXEC. this side effect is introduced in the emulated
version, after the deprecated mark exists. The patch only removes the
side effects introduced. And this(mm) is the module. :)

BTW, The link is the _first step_ in required(if the check is missing in
that call site, there will be a bug) call sites, which has been done.

> I do feel we need to better document these functions, so I will add
> comments. I see you did so as part of your other series, but think maybe we
> need to expand this and possibly rename both and add some asserts... it's
> on the todo list!

Perhaps adding sufficient comments is also a completely appropriate method
as another alternative.

Thanks for your kind review!
