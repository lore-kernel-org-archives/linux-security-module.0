Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E71C54A6
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334387; cv=none; b=nczcZBxbzpD2Zh5jEN49O69oUTMGBRAoc3b1JnjsPLZOgPnpmwNsyVkkuguHNLwfW3H7O8UTJy9ff3C4HWRHATH6i2IGJaOxlZxMYVSxf7Q8WyS8Dc3WnbBwM1TWfXJLKgYbbSFkFQ4MdOwqklqfRZ8th3FCPjWB1XXMhWVVhoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334387; c=relaxed/simple;
	bh=6xsGyvdgrzA9tWzH0xf7HP+L4ODLpgpCkWElzj+vao4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCzl2HySB0zZumNpmx9kXNYA8h1RN+ZCOBVbVNeiaCHLc5FlDc5buSBXVKeZoYBD0zLIqOwCmE+ZgBIhOucUPS0naEK5JVD8Kwj/PQkDgpClmM9QS/Gb/f1JiYr+8ySOYVzZiIsbfZyr9d84M7A/XtxDl+GH8mary8jsclNhoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cJpqOS8h; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cJpqOS8h"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f8c58229f1so9965427b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 06:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738334384; x=1738939184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l+aerKYBDSo/0m7wIE29H/4F+oEOdV4WNPtkzjhXyA=;
        b=cJpqOS8hizaavXzfy0LQOznD8LK1H2i1d3tbpwUx3PK4Qc7HoMpFr7SQnCtUo6+KEH
         nAriUDBpVdxDcazOFLl8gPb96kbw312Az4ZjwuP/yGwvsjAQStBABdSlcZ4Q+HGIXIsF
         mkCPnh6T6x6/+wrSCCfdufWa2HZVJsdRLS3knu9nN0/JxM9qUDSfze1eckP1hDCYDNFR
         6LG0kd0CJMGvYu1dsGzHHVwgrKhNUYxQVSqNgtRjjnnd0QPZemQkuJBvBhYn8zwAmrkG
         fpm71cr0cB9zBlwD1SBAldP0QnTcBGkStY/CbvXS8/9fxFuci7FzbI23zGSfBQQF6dWB
         D/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738334384; x=1738939184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1l+aerKYBDSo/0m7wIE29H/4F+oEOdV4WNPtkzjhXyA=;
        b=v0pYqXcVvVz/8b4MgD3BsCqij7iAmrisqhKPhWUURe+cC7Jk+ssv10UaJuQVFoUm3y
         3MqN20CF5QrYH7AG89eErEtppnhjekzLbPMg30LFHpQ/YQmyJWMzY96+5xtRVAJnZ/dj
         IC0l6VvYJMPcuJ837RTLypI1TsPsRfRJbC2CaBD5nfb52HYvrxG3oTLVebaCGWI4zUJj
         lXLzee1SHkcT8QRScOsOrWoXpcRIy2bhxz+cLZel0SShw6HGvGOSB1ORhr4Sm+7DuVus
         TzcKjK5ZkbzBCXthu3wWDUOYDyFtDEeJ0hbEXLhrfLq9K8VaqCLyYVTduWIdXdN5lrsf
         8OTA==
X-Forwarded-Encrypted: i=1; AJvYcCWp/heWHpZvzO2jjve+FujOmW8PGGL+o/QT3cEWRgagqPXRVF5G8cyWC1b62Hd6kVYdqCF/8JRHhFcp2vZOWfVkTka2MtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsIs5bnO4h3SEmh3g2QIYCI/1UJ7hhQCOO6Lip9vT2Md94YGpB
	OVZwP0eJmaEMBg67ANPQ9NfjXfsCdAxoiliJdEuyDYSie/m1zZOLAtcL3uAmxk970Wl4JxKu+k4
	w0Qk+Ycoskd46lHB1o+zcAAGqz8oGn5GRatYd
X-Gm-Gg: ASbGncuQqGYsgdEBdBBfyUs705/eLDtb0+nA0xOR4MU1idIO5lUlZOcdNe+oZtCNShv
	tzVrx37hgVDoeTrGcR732liTykU/EK6mGP7NZno8v1nMDAt90xkRoVFwGalNCicrJKCSkoes=
X-Google-Smtp-Source: AGHT+IHyZy2tWc2K57qbPizzQYtbfS/OLJCGfMsN3B8yddb8SJjDjY6kW2T7VzcXc7cUBMqnl5g6oMciW+s0Cp9InaY=
X-Received: by 2002:a05:690c:610a:b0:6e2:41fa:9d4 with SMTP id
 00721157ae682-6f8c19b2dfbmr61453817b3.15.1738334382440; Fri, 31 Jan 2025
 06:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129165803.72138-1-mszeredi@redhat.com> <20250129165803.72138-3-mszeredi@redhat.com>
 <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com> <20250131-durften-weitblick-075d05e8f616@brauner>
In-Reply-To: <20250131-durften-weitblick-075d05e8f616@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jan 2025 09:39:31 -0500
X-Gm-Features: AWEUYZlrbsxtsOAhUhJ0t0oHP88q3hy5Zk9DmREI8o_1taIviZd-nzn82eg0l6Y
Message-ID: <CAHC9VhTSt-UoGOZvez8WPLxv4s6UQqJgDb5M4hWeTUeJY2oz3w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 7:09=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Thu, Jan 30, 2025 at 04:05:53PM -0500, Paul Moore wrote:
> >
> > Now back to the merge into the VFS tree ... I was very surprised to
> > open this patchset and see that Christian had merged v5 after less
> > than 24 hours (at least according to the email timestamps that I see)
> > and without an explicit ACK for the SELinux changes.  I've mentioned
> > this to you before Christian, please do not merge any SELinux, LSM
> > framework, or audit related patches without an explicit ACK.  I
>
> Things go into the tree for testing when the VFS side is ready for
> testing. We're at v5 and the patchset has gone through four iterations
> over multiple months. It will go into linux-next and fs-next now for as
> much expsure as possible.
>
> I'm not sure what the confusion between merging things into a tree and
> sending things upstream is. I have explained this to you before. The
> application message is also pretty clear about that.

I'm not sure what the confusion is around my explicit request that you
refrain from merging anything that touches the LSM framework, SELinux,
or the audit subsystem without an explicit ACK.  I have explained this
to you before.

For the record, your application/merge email makes no statement about
only sending patches to Linus that have been ACK'd by all relevant
parties.  The only statement I can see in your email that remotely
relates to ACKs is this:

  "It's encouraged to provide Acked-bys and Reviewed-bys
   even though the patch has now been applied. If possible
   patch trailers will be updated."

... which once again makes no claims about holding back changes that
have not been properly ACK'd.

--=20
paul-moore.com
