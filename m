Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C72D603
	for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2024 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742850; cv=none; b=Mcs6LAoOPLx3PaTxvaDzxTUTaaFOalyh0h6Sk+x8EDA1bpjS2UEzz1+8dFJe/kbVMkfgIqePzRYT5jOCpK6uuNbD8T1V5iRi2Lf81VX7E6IBKUhoIzSFuU7t3EFXF41Ptmoyg0KW0ae1fBvfnriZQQ7KL+Qvkscj5oNwkDtGfGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742850; c=relaxed/simple;
	bh=awFHAY8XHcanzb6vy8PgRQfgEkCETQsPqaiNcN9dCNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEYCgl41kOcbKvIq9pEMzde/CPpPTO07F+sBF4PeSLSXd2geRbco76lC7ymNzI65S8r+9ZjNTeLb5AXvJkO/1I72l4HXQa3Evr3GyyvQcjSGBXnin4WuPJn66nCSLXxENaOOWdoVXeIc/cZV2RVCXkMIgIodLYdUwzk+zJUsl4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JeXwq3YF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JeXwq3YF"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61454c18b19so6211687b3.3
        for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2024 13:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711742848; x=1712347648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLp6wbIuNfQDM0GfRvpfhiQ2E6iE5tQL+A8qPraSqKs=;
        b=JeXwq3YFBES+TeraqLz78kx0LQYgwoj+avgqZjDdXSq/lzpiZXuSwtFeNurFeElccg
         mWjJEAonSvXMFrceWff5Jebm4CCkUwpuzJCL09JOv5KTLXGMysVbxrfSEsbC2824H/6G
         wbdhWwPkrgd03Wg0QCOhmJodGTzUhlhT8HBu8PkTKnfWbN2zaCkmho1GlwkaSP8VKb27
         7UoXuk407qGus4KBZKpXjg6Lt3HXxAf74O19Y78zFfBghs4fkUV5vv1v9VDze9QcTmwl
         5qk3rGNu5sos+zOluRmo57RCCr/vvTSRDKW3KqjWrydrW3yXI4wkA4f/RVf2QHOhEFNs
         bLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742848; x=1712347648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLp6wbIuNfQDM0GfRvpfhiQ2E6iE5tQL+A8qPraSqKs=;
        b=nmu2IMJ/Ky72aQGVfVcgGahWWr0XGOLl2+4M+pKmw+LxQA5dsqtz72ooL+KkoNhU1p
         TDDU/Dw7ClJcA13DFUMPl+NwzyGnBaC1ZYtGkTQrBGXS3pGifs+32mRDnhteGg4zXzan
         BhTrAJ6PxsUGu5IPcOXIwnO8T7+KD/Mt70WBRTcE8aKwC75P+onPNeL1R5LtYs3BytEK
         rpVt5jkUaS3rXhYri+PrbkA8V6BHWqVPTpSKl76jtn86HbYSuwRR2GFycwdzSvtXmWUW
         egd8257TTmCqxpP59hFJJvpTIhG9JzbOx/pmTkDTKZ4JoW08uWmDXZXuPXLIfjre2rBo
         vQSA==
X-Forwarded-Encrypted: i=1; AJvYcCUSFHDydZQLhdkJMUFpbn31EUzWY9U+tcXq0XihFhkxs5rpGRpjp4yEP3Pytw+ShC42c4sh/Z7adJ+9LthS7by69V1TH4VoajEn/Jr4gTba1WNIseDI
X-Gm-Message-State: AOJu0Yyd2das0D/+NYspMqWk/q0Ni3THqE1YjrccKh/szFNoiS7UJ7Fs
	V1k1I6YAtCsRPCRvHX4lJjjqQsQwbnPGdVQjQJpZvzexqq+i1GFNTdJrqSr5NMlb4TJI+Anv+xD
	yitMXDskESzi8oF2+tmyNYUeNSmL+RaBU06pS
X-Google-Smtp-Source: AGHT+IF52iikrW1UZtMubWG579ZKB05EShGB6ZY3hqcxgRjOBtdjDxcIkRRj9nzuYZ3C4mMWq/K2KgRzTACP7Neqh54=
X-Received: by 2002:a0d:f9c5:0:b0:611:278d:fb80 with SMTP id
 j188-20020a0df9c5000000b00611278dfb80mr3441269ywf.8.1711742847920; Fri, 29
 Mar 2024 13:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120036.233641-1-mic@digikod.net> <bd62ac88-81bc-cee2-639a-a0ca79843265@huawei-partners.com>
In-Reply-To: <bd62ac88-81bc-cee2-639a-a0ca79843265@huawei-partners.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 16:07:17 -0400
Message-ID: <CAHC9VhRN4deUerWtxxGypFH1o+NRD=Z+U96H2qB0xv+0d6ekEA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] lsm: Check and handle error priority for
 socket_bind and socket_connect
To: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	Alexey Kodanev <alexey.kodanev@oracle.com>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	yusongping <yusongping@huawei.com>, artem.kuzin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:11=E2=80=AFAM Ivanov Mikhail
<ivanov.mikhail1@huawei-partners.com> wrote:
> On 3/27/2024 3:00 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> > Because the security_socket_bind and the security_socket_bind hooks are
> > called before the network stack, it is easy to introduce error code
> > inconsistencies. Instead of adding new checks to current and future
> > LSMs, let's fix the related hook instead. The new checks are already
> > (partially) implemented by SELinux and Landlock, and it should not
> > change user space behavior but improve error code consistency instead.
>
> It would probably be better to allow the network stack to perform such
> checks before calling LSM hooks. This may lead to following improvements:

...

> This may result in adding new method to socket->ops.

I don't think there is a "may result" here, it will *require* a new
socket::proto_ops function (addr_validate?).  If you want to pursue
this with the netdev folks to see if they would be willing to adopt
such an approach I think that would be a great idea.  Just be warned,
there have been difficulties in the past when trying to get any sort
of LSM accommodations from the netdev folks.

--=20
paul-moore.com
