Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8761D0F54
	for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2024 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728682474; cv=none; b=Ts/hHuVWuXR6m4vJvCF1hKuUX0WGiXGCuVIZt4c0tn1w2eFCnnYPddv93DUjHVxPzfMP+SivvL/vG7tSyZq2NcMCxwJ5SIIuRYnGRzBzpcz5wpSbdvpnaUSFketnWiWECTXhrJDvuMVBpJ+XpzAvG0GW0SY/XQRkkCOipahojA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728682474; c=relaxed/simple;
	bh=yn68VGQgjuF57lFPHzPET93dI/gFBtZI+3oFtACRqdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiAK8goU5uob81aTUTm75BlkQPc/fmsApvcfHugJZjM57tYvqMFTBT5K0lo21hHpMszSpKJwICt+1iK2CwoYyF530kAWNUPN9A+ollpK25yB8AqpGCXci6mBJhyGedCSW6ug0ezn4WAkYoERDXgXF1Dgc2h9bG8m2oAXzwz+74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=caijQmlS; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="caijQmlS"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso2644262276.1
        for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2024 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728682471; x=1729287271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuJ38S9WNQES8UxG5Eg7yjwtIJRWC+46hl/pmxrvCWM=;
        b=caijQmlSLH6Mn6V9Bh5OtPmtrih6HODYry4AeeeOsNhI2lrdPj2P8CJcgedFPsFYnN
         9grM3LwYNldCHZawBfBC10tYjsH23tLkAMx86mX+dkgE/7e0mGpcGu+7U6E2HYBrdDqc
         dCUzZ3/4GQ30K5F4OsU9m1jbcF9YnVModAx/RdB1tIaYXbyt8LZw/trWf196QbIMkTnU
         +1hAWpqaXYsMBAw/4J1C3dOhLws2hKV12prYbtqY4ylJhHI4VlkhXU68mqDD57X/nicz
         5MGJjVhgKTGNyRIYt9DQCOTQxOWlOG51E3SVBTY65E8s19rVFXbYAfSPcJ3MiO3PJW37
         7lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728682471; x=1729287271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuJ38S9WNQES8UxG5Eg7yjwtIJRWC+46hl/pmxrvCWM=;
        b=f5iS/OGixoTiWDQ+xFk578VCjNEBXyYdMijW38/jom+o4A9GYzNssolYSmrhVUfMin
         jngKdBql/Im9SeyPKRuW7vNb/olZVcoemHC+zPbPNi3Cyz7MrSnnJCEGGvavIQBAOuxa
         GErdjYR0QdODQMvsAILxvhaii+/3cd0UafzlQzdE2duw5Cxsyg9kH6sTxj26SDBAxK2I
         CqJ3+AqjnE3KzvVzZxarlglIOQ0GJ1vHv5XRcvUzyRaPOwU/JTl0xkuwgdZLb9pIaWa/
         GalA3EyeJLnW0i4Jmp7PG8UcE4r4O/Woe7P+a1iB+LLI/nKUZq6cRo4G6mFtOsQVd4s1
         L42Q==
X-Forwarded-Encrypted: i=1; AJvYcCUY7e8L2vfV+CXcwQni4Aspv7MoAdOCroD3ghC2ztFIfxT5G4BFMIqmSjPEcwOq1IFAQB5q10Eop3EkK3Lbayxd+0jca9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2kOJRgp+fWw/agLAPh+ZBzpOs6qBMdzb7pcZdofbipsLbzksC
	PDR/d0gaFPWqgRMwRHNLgAvjFgRi+Jni+1sFAL9d8U/pE+B/n5q3hF5NBAYCo+nasWZ2ZXibzML
	6lR2A1U54M4iakyz9zF9A2pSscic6yvvVO6Jm
X-Google-Smtp-Source: AGHT+IFrYhiJio4X4+ywyBra47qcZ6SUO4xvjf/kfaS0SLCEASRbGZElMMGFLK5PU9YPz4TciK+hv+7VEGUf5UKSZ1k=
X-Received: by 2002:a05:6902:11ca:b0:e29:18e2:622c with SMTP id
 3f1490d57ef6-e2919ffb611mr3143224276.56.1728682471609; Fri, 11 Oct 2024
 14:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-1-mic@digikod.net> <20241010152649.849254-2-mic@digikod.net>
In-Reply-To: <20241010152649.849254-2-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Oct 2024 17:34:21 -0400
Message-ID: <CAHC9VhR8AFZN4tU1oAkaHb+CQDCe2_4T4X0oq7xekxCYkFYv6A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/7] audit: Fix inode numbers
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:26=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> Use the new inode_get_ino() helper to log the user space's view of
> inode's numbers instead of the private kernel values.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/lsm_audit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

While answering some off-list questions regarding audit, I realized
we've got similar issues with audit_name->ino and audit_watch->ino.
It would be nice if you could also fix that in this patchset.

--=20
paul-moore.com
