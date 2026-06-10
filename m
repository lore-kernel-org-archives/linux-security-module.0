Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443503AD530
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781125592; cv=pass; b=NUfvMQPlRf2E37QrXyOYWI2Tel4fF3AOwcxU4oBk8mnMq4bp9pLXzUIvo2RCJE2r9ONaY6Y5HaMrxMaaOeJSftUr6Td5J/qesgNSaM9f5NsaBroZyTQVDU7RH4U7EGjZ4fS2ZvBCUyCseGSQIPAOqsV1vzBolIHNZLSuYdk+kWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781125592; c=relaxed/simple;
	bh=8SPk+9kPUL0DQYsfiU6U+3rhy9CmKqHE6O0qDp+jLZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JE+infZQo0e7XqEX1cMLlgnkeQY3HiYjkkMARWm0RG6sJawm52XbUEbvksKqoSYGLE0TE8i1yewhSqqWdQqLaU1SIz7yPRtgT3W1/b+M4jMHSDwSLoRqY0ycL5fwtUIFZb9t8R/DM/XQqvSXXfVeUqFE2e+xDosPoISqZWASVII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWOwKwlS; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWOwKwlS"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7f5eb760240so6968247b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 14:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781125589; cv=none;
        d=google.com; s=arc-20240605;
        b=ZCxPijmHqxHzsEbemhZjVCPsxUfPTHzpQvL4Md5ri5UT/RHfFoaB8KeBampq0+lRfe
         G8Z6XSIOn/ZAt9+S4rO3zaF2KwMDxVyE1i5U2/pMeLtPV3XnqCHHFVrh05PguTo83+bh
         p/QhaiP2MIciIw7vkfz9K1JDPAIKMkx2yDUlLU1y0qWmBTlxLKDJRj9CjxVSooQA6N24
         mf4YqJKcvTRgMSpI5fxV3cC80klnVueXnMlXtBUZgQVO4ECmDvc87idjJ/5+kWE/FriK
         n5KJaeKAT5s16QwGgt8tirsYF0aKQ8GZ5/e8Vkt4kyI33qscs9ZbTXKvxfOqduOMSMjm
         1Rxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        fh=g6O4gyDvR4uP30pVJV5OVn18hNfjSTwghUZeA05nUbk=;
        b=HXT/jrVVHhwnUO1elr9NJ2/ts+32WpZO/Yb1RqrnYdtkRu0HFLpHlRye+Uv/Sg9UjR
         s4n5peeMG72slthkUzDmyud86g56F+1/MgSiSdzJ+jQF93FLYfOs/iaMBIfLb6gWgNBv
         TY0ESEpAy4TDIVPWjDmBKl2uK3rvZ1qQksU+Ow0kcjVkca+ObD5n0IJ76NNJ/fJeDHvP
         yO9Sj6IzFRlRMSyWxOq5x9kMHrjnJpLOCtj3BUwpE2zAMGZk2VHtWlN1ZvFPJy21fSZd
         EjEbEalbtPOUAdRgCVRBhmFQjmC6zKNb/QeCnoVRzp/YN/h5jYO8ywCfJPh/Rf/1rzFS
         QY2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781125589; x=1781730389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        b=jWOwKwlStXwGgUAXfngBzfebepF/l+Iz4nUi1RY4ZFUDUceLV7UGbSPy/9QVHif4B8
         ZPz1O75qxMy7MzdeNnHDuLBQRANDqdgtNr4gpz1YjTbGBhWiD5oYWhkIc+R75zzFDCkO
         Meumk/PL2hxGiDTi1EoFtI5Rjo6hDtBgNs4khoSmLMvoD3D6m4fDnyZeU2/SVa8Rl3Nq
         Np8qgXa+5CNjzN4wJqgw9w2Dk9ZrR505dzxMLNWm5lQRAcJlwSMMAmfpaaFKXCI38Fkc
         kL00/uRMaIP0VLi90TJNN5Ph1pRYS3cFKXlldKH1fiRvxQ998TEqxSQ9HgBoZT5xJce+
         N+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781125589; x=1781730389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        b=OBElfUyR17DD2tb+su6VSqJvBlUlOywH9e7mPK5n3b3n4kZ7ZfWnCJrrXz/CnZVyFW
         smc5d8YRjt5fl9wEEYtrJrhxncvUDhp0v7UV7Y5sD3vYE2AUqr7zn/XKQF7eeX5p1rCo
         HDNn/KmS7VTrawf//hjWyVkjV1XPdG+vsTILDhbbblvxWvZskSPYHXLt5kUvjBLTDQHg
         GTIE6s3hFlxdlUuA/HP3ItpMqbwAUkEll96jUbRESdyQ27N7asVIx2k04Z7PHmfvoUFm
         +7ujKZVKT6nn1xcPqgLTsg2Wwi6MzFHnU/33+MUfT3drh9ETPey9BmpAk6iCNRfHdwX3
         VjSg==
X-Forwarded-Encrypted: i=1; AFNElJ9bMX1p7mTetIeoHcXd439nVGmXtvIbsWHQZuJUXsO3H7GTXjMyHqElkyZ1FDSvS0hgrkS1gslreT7pdu5BBA+zgk60qFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyARxhw8EFg8SOb5Mw8GG6NsaJnW4EftavHAZgm0Abg1ivaUrZ8
	WUPCw9oLSMeZo009ngv9SYoDcuzLOJh1rfQY5AzFF9aBs0MI+K8YZR38mNiuhZrGUNgOi1WuZIz
	t/H44DOyhPEOf4Y1JkysVzaBOlwmoy1U=
X-Gm-Gg: Acq92OFtqxcVQ9yNeaFFAt/0q+PD6dKftc77WgY7mYhukYO7unqHz2/wjzKuWs4El8y
	a8QIn7Ykyrysm+4G/xtcj+V7vNyIXxJ5fmQhwJen6JxlBdiktp1hTHscPgKBh5wX2Hv18JjhDp/
	1BnvnNpNlmu2qTxM/mFCIBXJeLAwiUb7FQInjZ8SPFqDyKztzvcZIoZnNFVwKpQc0B8vN+8uq3u
	/u/fiAo5jxFe4snIwFtVMGypxiC4rEDX0nZEeh024Lyk0p8VRAarvhFcS+L+tJiJVuX7cAiMghm
	qGx3+TAp16Gp8o/yU+UeaTJ/gA==
X-Received: by 2002:a05:690c:45c5:b0:7e9:ab56:3c99 with SMTP id
 00721157ae682-7ed0adbb616mr276188567b3.6.1781125589039; Wed, 10 Jun 2026
 14:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org> <20260521133326.2465264-4-kees@kernel.org>
 <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
In-Reply-To: <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
From: jim.cromie@gmail.com
Date: Wed, 10 Jun 2026 15:06:02 -0600
X-Gm-Features: AVVi8CcLXClq9Fijm8VjZF47hQWmos5q_iXrehNZDw9kSOby-E_cMxEQI0SK-hU
Message-ID: <CAJfuBxwRuT1K=rjPX+sdNyYurEJ=OjqbJaSa_S6JnY6yzTwTvQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, 
	Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Baron <jbaron@akamai.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 7:35=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 5/21/26 3:33 PM, Kees Cook wrote:
> > Using Coccinelle, rewrite every struct kernel_param_ops initializer tha=
t
> > sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> > for example:
> >
> > @@
> > declarer name DEFINE_KERNEL_PARAM_OPS;
> > identifier OPS;
> > expression SET, GET;
> > @@
> > - const struct kernel_param_ops OPS =3D {
> > -       .set =3D SET,
> > -       .get =3D GET,
> > - };
> > + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);
> >
> > Using the macro for initialization means future changes can manipulate
> > the struct layout and callback prototypes without having to change ever=
y
> > initializer.
>
> Nit: For consistency, I suggest also converting the few remaining
> kernel_param_ops instances that specify only .set and no .get, such as
> simdisk_param_ops_filename.
>
> --
> Thanks,
> Petr

for the dynamic-debug changes

Reviewed-by: Jim Cromie <jim.cromie@gmail.com>
