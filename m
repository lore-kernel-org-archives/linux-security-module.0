Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CBD19C542
	for <linux-security-module@vger.kernel.org>; Thu,  5 Jun 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135368; cv=none; b=VxC+yQYkytVDwzH+6a5j0WSDjMdgQ/zjkqhN+X+Bpl/RFqTjfOyOL0LBI/Odarw2Cx/XQ/WXSyCyn4gfSyuPYa3P2+utjSlySXx6urcXiyIv2qW9azasc0FyGVak+6E3zoQaZglpB71wIeLbjCtn+YH9TBvqX1hyglv3S7Q67Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135368; c=relaxed/simple;
	bh=amp01qy5uUSMUocc/PTfwJDswPWfzDPEaflpMFjY2FE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TJ6DUbGP+Vx8RTghtwtdmG5T9jTd2p/v9KxhCZEZ9+VYNuYWUuW1iTUnRR8TRV5Ecp7Yh/gxuRn5oIvlcoiQ+yKRPkLpCNtAmMm7vaQaRaKQBh0LFfAGcjB2KPFIi3d6fHu3bIlFbXeRkzFdmMG1JRJMT5DWL87wZGnjjvCgv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAwFx7NB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAwFx7NB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749135365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtvpD/mblq6ZU2wSwo0XWZRr6MIudCLqH39Z6CB56zA=;
	b=OAwFx7NBabHZEfMk6hfR8rt0J5eaDmh0ya5mcEcAKleto5+xlRJGbxpsNIl3JLBXnp9pKU
	FnO7CBzCK8w6xzC4cRRQgDJL5Yx/xzmlpisr7pw2jOanuVPlOs+Oa1EYJd4vv6ArbUq30q
	6jdq7PNP46L3SxKXjcVwDmpcCM3+g8E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-VFuiEIxXPGGVkdl-X7cmwQ-1; Thu, 05 Jun 2025 10:56:04 -0400
X-MC-Unique: VFuiEIxXPGGVkdl-X7cmwQ-1
X-Mimecast-MFC-AGG-ID: VFuiEIxXPGGVkdl-X7cmwQ_1749135363
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450dada0f83so8439305e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Jun 2025 07:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749135363; x=1749740163;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFA6j3WG2u6wCRFKF+JPzUGEfqC8djtrecvjhVi86Lo=;
        b=ar2FXUk1S9eq2qwmt4eZudZGixP/qlqkjcNScsFnFPGvhjmASEiFMKgRRcUlTQukfY
         c+b/hjVMGcdkO2DhefuxzY/DiGnWPfaChF2HmOHCY0D88yBM69/bVE+dCK7mMNCw8O80
         XYy78XZi4FWDiB9y1rTUD7kuDOfi2iY8SqmOmqM+nvH66jL0elRIiRyAk6PG3hODR2wF
         8utAxCIVjMj8uqYmGIUX0CowD2YaXvPCz1H33LEfD+tc8uea22OBEBfMEo55AGgptyz/
         QhvKatLU4/DDvV7tAEKvyo5wzkGTldt+jzAHTZc8WFuawt/+wvgZQUzzB7NTVMqb3Exi
         qybA==
X-Forwarded-Encrypted: i=1; AJvYcCUylOv2cbB8h+GS5bOX7NEraRajvRUs//czmH/0nOq6lEDcGgP+eR0y5J9wVwhvcS51dCrZciPxhEHLih9boETEaCkZFS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA5S4U1BX2vpL1RrtOlYSvkrQm/uqzy92hTkdNpumBIoFmz8bR
	vHfyALMsoXXfJmzNA9xlQslW4Q0TSo03NLssUGUHojAdKwpXbh7isxR+dukBjde6F3eThVE8v9b
	XTjZYKNV3iYoUtWmyqltyKY9Po53l109VsBihZ2k+kZ9roDNhFsglKbGMRPyitrVqTNsO1D9rTa
	gj5w==
X-Gm-Gg: ASbGncuu66DOI/QJc7VVGkfj+bdPOm06LBJ51XkmoaBV6Qw6OEFFsuup+40fhYth1B7
	u3pZiX3QRUMcNewkpm4tThrg48p8mwbyR803mVcL1TBIELNIi3Uix4Tx4lleQAsYC1/GfTwLhMt
	p6I1HvziquQ9hvX624VHJFvFEP3ODhtZlttX/92V758zVaJLjNvoZP8QofADyS1oHa64c6aJCX2
	QjkCU6owGr7gWiu1UQSQybCUdwGRmEsKcjjN3Vhzi8NCeBaaX/o30fvljLHdyuh3kmr5QfbIq8J
	NXBhqZ4=
X-Received: by 2002:adf:e38c:0:b0:3a5:2670:e220 with SMTP id ffacd0b85a97d-3a52670e28dmr3061231f8f.32.1749135362776;
        Thu, 05 Jun 2025 07:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA81c6wZglVzh0Z3/rZiV4JQo/XmLeKsTiTnUWO5wj0USvJJ+iJpt9siQ/hlalGpRgG5o3Zw==
X-Received: by 2002:adf:e38c:0:b0:3a5:2670:e220 with SMTP id ffacd0b85a97d-3a52670e28dmr3061215f8f.32.1749135362368;
        Thu, 05 Jun 2025 07:56:02 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cfe3sm27314005e9.23.2025.06.05.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:56:02 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-modules@vger.kernel.org"
 <linux-modules@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, David Howells <dhowells@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Peter Jones <pjones@redhat.com>, Robert
 Holmes <robeholmes@gmail.com>, Jeremy Cline <jcline@redhat.com>, Coiby Xu
 <coxu@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC 0/1] module: Optionally use .platform keyring for
 signatures verification
In-Reply-To: <435F53C6-DC08-49CA-AA36-9747FC1B50DF@oracle.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <0FD18D05-6114-4A25-BD77-C32C1D706CC3@oracle.com>
 <f0b37bc55ed3c02569c74f0fbdb6afa8efd329e2.camel@HansenPartnership.com>
 <87zfemoc76.fsf@redhat.com>
 <435F53C6-DC08-49CA-AA36-9747FC1B50DF@oracle.com>
Date: Thu, 05 Jun 2025 16:56:00 +0200
Message-ID: <87qzzynsov.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GkgmW10-34MTurfLJnR6YVZgFvthxZWQ5YXQtrkyyY8_1749135363
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Snowberg <eric.snowberg@oracle.com> writes:

>> On Jun 5, 2025, at 1:54=E2=80=AFAM, Vitaly Kuznetsov <vkuznets@redhat.co=
m> wrote:
>>=20
>> 'certwrapper' offers _a_ solution which is great. It may, however, not
>> be very convenient to use when a user wants to re-use the same OS image
>> (e.g. provided by the distro vendor) for various different use-cases as
>> proper 'certwrapper' binary needs to be placed on the ESP (and thus
>> we'll end up with a bunch of images instead of one). 'db' is different
>> because it normally lives outside of the OS disk so it is possible to
>> register the exact same OS image with different properties (e.g. with
>> and without a custom cert which allows to load third party modules).
>
> Could you please provide more details? The kernel module is signed with=
=20
> a specific key. The =E2=80=98db=E2=80=99  key in the cloud image must mat=
ch whatever key=20
> was used to sign the kernel module.
>
> Why can=E2=80=99t the RPM package that contains the kernel module also in=
clude=20
> the required =E2=80=98certwrapper=E2=80=99?  When the RPM is installed, t=
he appropriate=20
> =E2=80=98certwrapper=E2=80=99 is placed on the ESP.  There can be any num=
ber of 'certwrappers'=20
> in the ESP. Doesn=E2=80=99t this solution address the issue?

I think it does but let me elaborate on where I believe some (minor?)
inconvenience comes from.

We have various actors here:
1) The OS image which is coming from a distro vendor.

2) The user, which takes the OS image and registers it with specific
properties (including 'db') with various infrastructures (e.g. different
clouds).

3) A third party kmod vendor which produces a module compatible with the
OS version. The module may only make sense for certain VMs on certain
clouds.

The customization of the VM normally happens upon first boot: a generic
image from the OS vendor (1) boots and then some provisioning agent
(cloud-init, WALA,...) takes over and e.g. installs additional
stuff. This additional stuff may include third party kmods from (3).

The 'certwrapper' must carry the key which the third party vendor (3) uses
and it must be signed by a key which the user (2) put to the 'db'. If we
want to have the 'certwrapper' shipped inside the same RPM as the kernel
module, it will be signed by the same third party vendor (3). While this
looks a bit weird ('self-signed certwrapper'), I don't see why this
can't work.=20

Besides the need to teach (3) how to build certwrappers, an inconvenience
in this scheme comes from the fact that to activate a 'certwrapper'
which we install from a custom rpm, we need a reboot. Cloud instances
often back burstable workloads and this can be seen as annoyance.

--=20
Vitaly

