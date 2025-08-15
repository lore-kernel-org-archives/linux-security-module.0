Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2424E319840;
	Fri, 15 Aug 2025 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755239657; cv=none; b=Rre5giVPLRFFnYOFXaQWrkrI0uUbdpy56h4LGdF8UhNUNNz+1+WQYyp7at4w8hLXdmLUTna5V6Sih9UHI3AiEICb6331B/GimudwitBkRx5Dre7eVgtgE0NdCJoUhl1oRnK2e6o56gKbQwF83G/CbUDQkKQT2ZW/FdCZ2xEPOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755239657; c=relaxed/simple;
	bh=kuPdCpuTj1FBY4yhEPLgSb49bXec4fC3XCBOV2asUF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmDyCvR4gU/qbA7LjLwire37CIFWtBbXS7eVuqyDmBZ6UGcp9DUnS3i5iOlYXV2mH1hwvVo3RwNv09FCEOsT/6LSKmAs5RLOhZkopovl3yFztqcy6WUyZ0vDauwGfdzLHcIifNwhPKeOKdWNqsYQpaQRbMTyBh1jkP45trj5EkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+E8hoKh; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+E8hoKh"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e931cdc2e4bso1761684276.3;
        Thu, 14 Aug 2025 23:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755239655; x=1755844455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuPdCpuTj1FBY4yhEPLgSb49bXec4fC3XCBOV2asUF4=;
        b=A+E8hoKhzp2sEKbQv7012P0ZucPR+zdgP6C1k5I9KhfZgII+WPNA5ZkWOYjxR6qoFV
         47VfhiSpX6NhP5U5MuMGM1FzVPP5KF4TwrTEx9c7nq89AVOa+O0FF7ZLQrvyCPZ27vqa
         mtCxLtutnk/QCROEubwUvUhX5Vt8+uib7lq7kOpbxsj8GrylyeIYnI8lH3YAPbfGpA7F
         j2rJjXVwrJh+lEaQtfGPa9eg29k/cgIUcgDofcS2QzK9lzdTF70qspDh2uV8fLoJleCH
         kxa2flhz8kPC7cB+4el2KToqILDM+BsFXoSr/i/QUQFaphtRcjPoi4VqxeZxlwr5d7t9
         tLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755239655; x=1755844455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuPdCpuTj1FBY4yhEPLgSb49bXec4fC3XCBOV2asUF4=;
        b=hw3rQWlpeus27QPUXuRgbMeLGY8cU06k194cFRPa+4e2M/ZEwnOdtwgu7OI6ejpP0a
         4FtCB5P6f0lJDkholbQGpOeOmYx9t+wUeX9abeW93hLp7KnPqkioMcU9P5tcEHMwN6SV
         ImQ5+MnBfM4i+pg+4U6jeZbDTypIHubTS3bmkUzpDr7TNXWUWGmwlnRwciCq2G3wk+VF
         pQvC9l8AkXIz4N2mIm9ONmKddo/P9k9tZgxNO7i3pSZgjGeX63dI8r5AxDXyu3poNsc9
         L7i/SZ4nbFzR2FyZ4TGwwjg0MgmaKxhgAvv5WZ9bw7O9c7auzx+No5RI3H0SbFQo15kY
         saaA==
X-Forwarded-Encrypted: i=1; AJvYcCU9R3mRf3ou+5fV32GM9Smb/Qq1OH5FMt8etTAMBcCAZjb/PaoOTS+86IWN5Y0nEomE8WpmV8RT1lJpDc5rZ88w5zlXiE/L@vger.kernel.org, AJvYcCUeVXy5TOQsgUnzuo7zhfR0JCzEMlhgDS1rm7WRqcq3NmRPu1/fjnXh8P06B8P7vc21FIZtzYXcw4aXTgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR22L075PpVgHRTRwMf11Z+72k+5fYwK0wFZj7PQfsExehvGb7
	XLLBfZCW4qNm0E2uuczceW3M/mFrCOXmTHZVlbdGufzhqe07Kf7L3GiDswqRkNYEZ5w4mlQmIib
	zA6WDOKNRUaxexyh4TWIRNSZZrdSbLfU=
X-Gm-Gg: ASbGnctOA2QoDHZmzaDDK6l3KSl1NEOWAWxoqla1BZtk7ZKvhYHcIbnDkH7sHC5ieXu
	SSC/gJnWkh1lINa6umb5LeObqACKt6yArid56udjGyzfCAQ4MZdKxFm1NTq7xDb0mg2ah7ijrnC
	5TZkq4aMtrF15JCCSEUPVD+iFThVDAI/gHcJsvrSlAcV4uCQ/4ZJjHTeBQAjWUmOry3FsdSanHC
	dYbvDc66gp9dibp8wbjvvdI23EjngdDtcGcC3hO
X-Google-Smtp-Source: AGHT+IH4dxohOh7qqn9xS+FXF0LJU4Rn2rbnVst81GNs7v9pVTjVeAoxkPTiRwcWbs/IDQdt1EluIl9NmK/g5rkKxiw=
X-Received: by 2002:a05:690c:4c10:b0:71c:3de0:9687 with SMTP id
 00721157ae682-71e6dd33a93mr13502637b3.35.1755239654844; Thu, 14 Aug 2025
 23:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814165403.616195-1-chandramohan.explore@gmail.com> <aJ6zKriNeoM4B/km@bhairav-test.ee.iitb.ac.in>
In-Reply-To: <aJ6zKriNeoM4B/km@bhairav-test.ee.iitb.ac.in>
From: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
Date: Fri, 15 Aug 2025 12:04:04 +0530
X-Gm-Features: Ac12FXwMQOi8Fm4tfQ_EIB_XLNT01Ea7X8vPl9CSOiR843YJyAaCBHL4B4dCFE0
Message-ID: <CADBJw5Zb7iOuzceDjeJ3e4JWAupxOTRnM62SmJFjv23vS-+bfQ@mail.gmail.com>
Subject: Re: [PATCH v2] apparmor: Remove unused value
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shuah@kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 9:40=E2=80=AFAM Akhilesh Patil <akhilesh@ee.iitb.ac=
.in> wrote:
>
> On Thu, Aug 14, 2025 at 10:24:01PM +0530, Chandra Mohan Sundar wrote:
> > The value "new" is being assigned to NULL but that statement does not
> > have effect since "new" is being overwritten in the subsequent
> > fallback case.
> >
> > Remove the unused value. This issue was reported by coverity static
> > analyzer.
>
> Hi Chandra. Do you have Coverity ID for this issue ?
>
Hi Akhilesh,

Sure. The Coverity id is 1662453 (
https://scan5.scan.coverity.com/#/project-view/65357/10063?selectedIssue=3D=
1662453
).

Thanks,
Chandra Mohan Sundar
