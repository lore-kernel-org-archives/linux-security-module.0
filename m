Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C078156222;
	Wed, 25 Sep 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727255406; cv=none; b=cniDk/nvgltVqiHB5AcZzEnuxKYBZ97j+40YIOq5rJnQoY8pEnS7qJpwMv/UhTEXUFzZg/LaXjriT+zeMmV3Nsk1z3L6zSHt/gLNqBpQVmwS51vWOtd1dydhZK74qV/XZAp8Twm1pgFfz5oQ8TFkz1dEtg0FD84zqCEK05Kcjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727255406; c=relaxed/simple;
	bh=KJNitsyKCNYW8WsaTmTs6kzhn1+MWzOgiBu6LL80W0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2/pZWeVITfAek8vmGRdK9ArJ5Wd5Q0mQI1CdfwEqdhIZLemtATmAf5roNd67gVZ+e00qU4/MM1Zd+EpNUQ4dO8At/CZfCNWiTKi0kHTO4W4DIeYdwB0uqDcQayLigrU7BwTMYRj5Y0n12QQSOfnBokXw5/NQmrfDynsngVSo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B//BRwPN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B//BRwPN"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5365928acd0so3171914e87.2;
        Wed, 25 Sep 2024 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727255403; x=1727860203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KJNitsyKCNYW8WsaTmTs6kzhn1+MWzOgiBu6LL80W0g=;
        b=B//BRwPNWa+sdYrHZC8rmSU+zw86wnzhZxXehhIkkYjAFqtOrJ17Pz+q+ZTROjxodd
         BCxt+uW797XU2KLPK0dxJ1Xysl4ZsjBTDOAxC/EiOZ/ecJQg1qwNBTuXCKTp2hq6CdL7
         BEC7yUzDsXSdJ+soZlzlurDQSQhyg9RWZrve9cv/R/8ywvuuTDwC7wjr8WO/7mrIoGBz
         mggWb80oWQ14hmvZsWzMubciHXnRlifAUQofEGmZhFTTNEQ+i5+PpipD1VwNoN1GLSF6
         H7NzE3p9WrUqswGqQ1dJX98gc0HIwBmuJlq9qtV6xGplSN4QiklO2+Vai2ZZAf7b14Rd
         vsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727255403; x=1727860203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJNitsyKCNYW8WsaTmTs6kzhn1+MWzOgiBu6LL80W0g=;
        b=Gc0sa6W/+X8xv7rLgtQkil4J0vyO6iX38jTrKH1FV/+2OWiAXuij1lGrMBW/JnT8Kr
         ozTjRxFUx7TE0sh+bGUEbs0YicCbp7g9T4sBp+HGiWphyeeM4OSJnNZqG0O5wVik31qE
         zQsC5+Ft1erJUxylta1YdR/4mwq1gQTL2xtN3+Po9JTHmzuN5h5OotxOYrFxoQbzI3oD
         w0h8JImY2y4c1MhSP6aA1rAt8Jt6ZPYvv1nw7xkSQ/0RVW0pN2zT7z6LyNvLnE67d0y9
         MLb/Jrj4gy82GpTlZJ7e55jM5wwvlvTOpBxlfAaRvGahFjR0jiCoyTaAHGnhQXQigqKU
         VAtg==
X-Forwarded-Encrypted: i=1; AJvYcCUY52/+AvD4wKnkznM24E0Qjaol5VFY6bx1XAfTvxXUMAl2bV2SDuToFducvvfME9ZZ+67kAp3mgSqIO9SrUFe8iGVmFN3W@vger.kernel.org, AJvYcCX80w1osuIhyIhSKQer5X/hR7oTTP0IhjEE3dI5M6enH6/ytUnWXYhANN9g0agdVFVqoQcMRnxT+1LfvcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8VzsK5+/nqC7+trFHpzHApEaiS0nIe0rCh9iWFsZH2CFE/Pji
	fsQzv9Vh1BOQKbdWy/vTYYnH+3avf82xOMiHzOIIsdnweKOCx0deAW1/GtnS/8liG2qMQUt+v1X
	22cPioQcmrPwZDJ44LNmNYM6FmYk/YMQK
X-Google-Smtp-Source: AGHT+IFe0eFSdFHtx4vDmmNqJptlJb98VcDaGToQ02Y9mXP2tAtI/AVgR/sheKHABwSRLmum1zOsjbmvSENKOtB1wzY=
X-Received: by 2002:a05:6512:3d23:b0:533:4b07:a8dc with SMTP id
 2adb3069b0e04-538775391d9mr1260207e87.35.1727255402704; Wed, 25 Sep 2024
 02:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925063034.169-1-ebpqwerty472123@gmail.com> <72050879-4546-4bc7-9983-79ad437594d4@lucifer.local>
In-Reply-To: <72050879-4546-4bc7-9983-79ad437594d4@lucifer.local>
From: Shu Han <ebpqwerty472123@gmail.com>
Date: Wed, 25 Sep 2024 17:09:47 +0800
Message-ID: <CAHQche8ijvNfKHBLV8BWWq85rjKQbjO+0w2s6kj4V3OpBANcuA@mail.gmail.com>
Subject: Re: [PATCH] mm: move the check of READ_IMPLIES_EXEC out of do_mmap()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, Liam.Howlett@oracle.com, vbabka@suse.cz, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

> You have sent this non-RFC intentionally conflicting with [0] to provide
> 'alternatives' that is not what a [PATCH] submission is.
>
> In any case, speculative changes like this should ABSOLUTELY be sent RFC,
> and sending things that are merge conflicts as ordinary patches is actually
> bordering on being a little rude!
>
> I'm sure it's unintentional :) but for the sake of us being able to work
> with these properly you should just send one as RFC and ask whether it'd be
> appropriate to send an alternative, and just allude to it in the one you do
> send.
>
> [0]:https://lore.kernel.org/all/20240925081628.408-1-ebpqwerty472123@gmail.com/

I am very sorry that I sent the wrong subject which should add "RFC",
due to lack of experience.

> It's a bit weird to send 'alternatives' - you should by now have a good
> sense of which ought to work, if not perhaps more research is required on
> your part?

I think both solutions can work, and the preliminary discussion is on
the mail list for [1]
(as this issue is related to security before it was fixed, the
discussion is on security@kernel.org).
The choice depends only on taste.

Link: https://lore.kernel.org/all/20240919080905.4506-2-paul@paul-moore.com/ [1]
