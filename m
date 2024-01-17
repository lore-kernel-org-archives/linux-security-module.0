Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FFC7465
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jan 2024 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455843; cv=none; b=UyJvFpv7CzTiBNnukFCjTyPBd+JFzvhnjJTrp/EbT39zedWOq3M6JW0Qhx0LHRM6DFaXvNREc1K5kwBTkZO2V3HY5J/AkIGCxI5wQkCApznUeXi9+mHdAkHrm+lyqDOTuruUuty3/FnwfHOSLiFodNjW/e8CIgMWMqakfwDiefk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455843; c=relaxed/simple;
	bh=3Rc/iB6lpKaZmLswe3EBoqxgNQFU8aEwulkS42oghdE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=k+cicz4hiWIOWwJAdZfHhurEhbWUHfHZHgLTgPNDl9J0B3Y3BgzrHORI5h4aOi9BfU0yUrhwuRTFFkkQP8B7nVFWSMHEz5YP2sqfZid6jeEnPkF6n2LhE55myqDyw9d1DwepS6MAn59zmN83C6lMmECaLUxs27AyEUMe0BGcig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HKqPz6hz; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKqPz6hz"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dec4b7b680so3609948a34.3
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jan 2024 17:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705455841; x=1706060641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCyW5jgYL0FNfi9sZFaXkPZnRkjGgNqTM8Cun5y6rJM=;
        b=HKqPz6hznYnZNcSvv6+JRTq0qHiw2CjjJfH6j25HrK+deJ7ihcC9cmXhmkNxwPX2AZ
         SIHSwBltMqI4/dVjB19SRD+u7L+zGwREhe7yGBh0blNOwy+Nabn1ovYQqkNXD8T5auqA
         FNDfe2QJRQ92zgP3GjbXiSbIp7pklZp+F08xooi2n0v4tKMbrzy1ZGpdL7LDLpuXfapo
         n+tOQtC5ndq2MqjlIZ6q/XHlPpmudn0De4yiAGUTJWTv8QCaJjEP+KGz61GhPD6SGO52
         5tYNN48M3Fc7fg8nXKH/PzQlZWA4VPm/3AJUz0MRb5Rky4VZesjIk0GhOOVFFADm9eoi
         ktjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705455841; x=1706060641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCyW5jgYL0FNfi9sZFaXkPZnRkjGgNqTM8Cun5y6rJM=;
        b=orivUl0KGVRxMsKRtgHNA+bCHtk17NI4xSEirhJEcviP3ASYbPBWMwcHKcH7UdHmui
         ibQzQgfEwqR67ay9BaNOSgVb5p/o09U98lnqWEEq2enPeY4tlwl3ZiSA/F06qiWEGF6P
         xNRnxEXyBQRP7LiGsgOT3aelF/2N/HLnS/5IsR+PisukLBywW4x9VvU3Mb0CzAe7s640
         WIwM9UPXkIW3s9EoPnaixBAQWz3G9olU3ytdB/xdYlTF6NYJ4whbP0cFIU/+DrwFE8RY
         +fBtAzWUmXColcczTXYJ/RLNjzBXiodsD8Poh13uIhIZ2ObG123Pk46Vzejqobehg9Jo
         Bm+Q==
X-Gm-Message-State: AOJu0Yxl3F5W7/LRvz78Cug0i/sU+2bxTRtJ5hP7xsQ9Bf7ekXRd8DZe
	+d2i4V629wtjIW07yumnDjjP8FyLRBAx9bj8PmD1UFzkKFjU
X-Google-Smtp-Source: AGHT+IGldAD4mdJNoJmIKE84COr9mosuz4vTOr5EHnkC1oq8G7bbXYyK0Di2ree/MvwG/EMobDC/p0sRp20Ly3A96M4=
X-Received: by 2002:a9d:628e:0:b0:6d8:567d:ed18 with SMTP id
 x14-20020a9d628e000000b006d8567ded18mr9306987otk.7.1705455841107; Tue, 16 Jan
 2024 17:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112074059.29673-1-hu.yadi@h3c.com>
In-Reply-To: <20240112074059.29673-1-hu.yadi@h3c.com>
From: Andrei Vagin <avagin@google.com>
Date: Tue, 16 Jan 2024 17:43:49 -0800
Message-ID: <CAEWA0a6CUh+Dma5eCPqM-2oc4Ah8jrFkeNgrB0Trr7paaUT6Nw@mail.gmail.com>
Subject: Re: [PATCH] selftests/filesystems:fix build error in overlayfs
To: Hu Yadi <hu.yadi@h3c.com>
Cc: jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, mic@digikod.net, amir73il@gmail.com, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	514118380@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:45=E2=80=AFPM Hu Yadi <hu.yadi@h3c.com> wrote:
>
> One build issue comes up due to both mount.h included dev_in_maps.c
>
> In file included from dev_in_maps.c:10:
> /usr/include/sys/mount.h:35:3: error: expected identifier before numeric =
constant
>    35 |   MS_RDONLY =3D 1,  /* Mount read-only.  */
>       |   ^~~~~~~~~
> In file included from dev_in_maps.c:13:
>
> Remove one of them to solve conflict, another error comes up:
>
> dev_in_maps.c:170:6: error: implicit declaration of function =E2=80=98mou=
nt=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>   170 |  if (mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) =3D=3D -1) {
>       |      ^~~~~
> cc1: all warnings being treated as errors
>
> and then , add sys_mount definition to solve it
> After both above, dev_in_maps.c can be built correctly on my mache(gcc 10=
.2,glibc-2.32,kernel-5.10)
>
> Signed-off-by: Hu Yadi <hu.yadi@h3c.com>
Acked-by: Andrei Vagin <avagin@google.com>
