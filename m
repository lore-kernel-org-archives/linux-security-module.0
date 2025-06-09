Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7769B211297
	for <linux-security-module@vger.kernel.org>; Mon,  9 Jun 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749459489; cv=none; b=kmR3wVCqiApIOYPpHyFIMmC/2gQcZdJI67N2VWW8y/xBG0DPvRUW6i3UI9nQeH5WUkOrHpz/mKLqLWZwPt5jLKolN4O3yD3kOKTZG78xEmYv6N2S1n0T6t0AnkgiAyreqqjbp8XIfDRGxW6b0eW4v9AKlAaXp9YK8+26Xb93+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749459489; c=relaxed/simple;
	bh=tObexuNu5puy0S/zrHD6bJ96PlTpeqIfPPG17mA0siE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p0ew6CTgBAFZGdkmcxIlezwXH1PbDp/s7vciMtY9QRyEAo4D6oFo4eKXORfiA3csRVv/R0lyqutVdwMzJxGK3hPvs532n2oOez2QzrBg9dSNMBv7x5x5sR6SH101IuAEGfvAPImW9FzA06RS95+7OD1QO9x2Znd4Ih5Q2DVJAjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKsRQe6d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKsRQe6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749459486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EAX9gR6Ry+BCiLbmBNWFHsPfQj/lBkDp4XOdgquTNsY=;
	b=cKsRQe6dUTDzZ/u7ywx5Hh+KHOVIw4dLuQUWZkZXaJkI7I4nggKjmF+i2W/Aq8TPbHAA/J
	87Q25IWnG06oCMKbXQK3JqP0pNvUkIXXXjncduR8aXvUSaWLrzgsWHs/YRqj9THmOqha+C
	4qua3RKkow0D6VoTV0sVEBT1ML61GRU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-1xF6PWdlPMqjMprNfEaweg-1; Mon, 09 Jun 2025 04:58:04 -0400
X-MC-Unique: 1xF6PWdlPMqjMprNfEaweg-1
X-Mimecast-MFC-AGG-ID: 1xF6PWdlPMqjMprNfEaweg_1749459483
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a50816cc58so1228977f8f.3
        for <linux-security-module@vger.kernel.org>; Mon, 09 Jun 2025 01:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749459483; x=1750064283;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAX9gR6Ry+BCiLbmBNWFHsPfQj/lBkDp4XOdgquTNsY=;
        b=pGcxvyLlOqXq5m7D5g0sPacPGiBAAQlsmZ6Ofw7FcjbrJJEgHjOYqF0BJTpfZYmdu1
         +Qw45bTyyprh/zmWeBNz/KBA/F0R+BpDiwqEv064+JE29V6QIr6b8BwX+7a70QiPzdIl
         8YxYfXlS/jlQwG8a9oWGkjwAnC2p8PfdW8fHVDzlHFUt5ueTMlD42U581qkjjLkRA0+N
         zAZZ5ZCQ6ULy+HROp6KqoCnneNCbnPIjkIr/C1Shn6k8GeG6XhgwN5kxjRqUJBdQzHiW
         oPQKFr/amKHvB0jpdH2ZqtC56aO2by7S048mJhG20qhDjTRp96VOILvXyquIUf6ZveHf
         ngqg==
X-Gm-Message-State: AOJu0Yxs/YJFwPsz2Q3gor34iYM3tOTnM+xN+arytDT2QsZiCei+uV27
	p2y6Lj3kY8k5JcRxBh5J9bf9pLhTA18Pl2qF4m62BItlH8HcUbNIYRcWkgnhMdv3p11yr9YfXEq
	b0ipae8HIel7iPf/VQA+dARiUNps6uuSCR5vl/ei9i+UMJmFkuLgwraDWc8n92/IKelsMb8nqwj
	6v5g==
X-Gm-Gg: ASbGncuc7Ntnlwc7yv1udl4yxHGtAWd83fNucRGdolaP/979xDavF0C/oM4d5vIvy6m
	qmTA9WWPsmuBJ23bM3vTQb93zCZ5UTAYYXaWQV+wz9fk0mr9nRCDwMNwZzxkN6afz/ENJUc+Zfe
	lG8PkkiwiBIhZMnePx8o/LRYYJUpkByPgIM/VIbTohnZX2+twbr9LCWg3sysR6ss/eL9Ap7szNJ
	28yyGJHDpIeHAP9rYPL+DbfLRVeYgalsyTSEORMrvnn9HLW/XIBBXiscffPcUMqOk2ttl+DnRFf
	Nnk8q8NRF7HbjPs+lA==
X-Received: by 2002:a05:6000:420a:b0:3a4:fc37:70e4 with SMTP id ffacd0b85a97d-3a531cf5be1mr8000749f8f.58.1749459483403;
        Mon, 09 Jun 2025 01:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGKstU+gvDYJRoCuhWj9Uy3B0R5FuTJdpuAKJpWIzyKGQze6gxwv3jbQl0SI7KqRYCXE0l/g==
X-Received: by 2002:a05:6000:420a:b0:3a4:fc37:70e4 with SMTP id ffacd0b85a97d-3a531cf5be1mr8000722f8f.58.1749459483016;
        Mon, 09 Jun 2025 01:58:03 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323be604sm8881091f8f.42.2025.06.09.01.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 01:58:02 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Peter Jones <pjones@redhat.com>
Cc: "linux-security-module@vger.kernel.org"
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
 E. Hallyn" <serge@hallyn.com>, Robert Holmes <robeholmes@gmail.com>,
 Jeremy Cline <jcline@redhat.com>, Coiby Xu <coxu@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC 0/1] module: Optionally use .platform keyring for
 signatures verification
In-Reply-To: <a9bb8b0cfd1af85443ff8ee615b3be0fc705ce02.camel@HansenPartnership.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <0FD18D05-6114-4A25-BD77-C32C1D706CC3@oracle.com>
 <f0b37bc55ed3c02569c74f0fbdb6afa8efd329e2.camel@HansenPartnership.com>
 <87zfemoc76.fsf@redhat.com>
 <e4e838d03b3619df5523d429e0cd8160a8aef9f8.camel@HansenPartnership.com>
 <87tt4unw1w.fsf@redhat.com>
 <a9bb8b0cfd1af85443ff8ee615b3be0fc705ce02.camel@HansenPartnership.com>
Date: Mon, 09 Jun 2025 10:58:01 +0200
Message-ID: <87ldq1nvfq.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ewiOvSaMe5e7oDw4iBNZJghw541OwiY8_yGzr5eTkHM_1749459483
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Thu, 2025-06-05 at 15:43 +0200, Vitaly Kuznetsov wrote:
>> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
>> 
>> > On Thu, 2025-06-05 at 09:54 +0200, Vitaly Kuznetsov wrote:
>> 
>> So far, I got two 'runtime' ideas:
>> - Observe MokListTrustedRT and distrust .platform when it is
>> non-empty. This can, of course, be combine with a Kconfig for those,
>> who do not want it at all.
>
> Well, not sure about that specific variable.  It seems to be set but
> not used by shim (however it is used in the kernel to decide whether to
> import the MoK list), so how would someone with a current distrusted db
> get it set?  But there's also MokIgnoreDB (which is actually a RT
> import of MokDBState) which is used to prevent importing the db certs
> into the platform keyring in the first place.
>
> I think the reason this is so fragmented is because we didn't really
> co-ordinate with shim when all the variables and switches were added. 
> Perhaps we should document all the variables and expectations before
> deciding on a mechanism? 

I was hoping Peter (pjones@) can help us here) Generally, I agree that
as these variables originate in shim, we should describe them there and
not try to give them some potentially undesired meaning in kernel.

>
> The one thing we can guarantee is if the cloud use case is booting
> without shim (is it?) then none of the RT variables will get created,
> so checking any (or a set) of them would work.

Personally, I always advocate for injecting shim in the boot chain at
least when distro kernels are used: shim provides SBAT revocation
mechanism which is likely going to be used when a new secureboot related
vulnerability is discovered. SBAT was used for UKIs only but a mechanism
for embedding it into the Linux kernel itself is coming (already merged
for 'zboot' arches, pending for x86). If, however, someone is signing
his own kernels and can use 'dbx' or even revoke the cert in case of a
problem, then I guess shim can be avoided.

>> and/or
>> - Sysctl toggle. Keep things as they are by default but make
>> .platform trusted (either for modules or for everything) when
>> switched 'on'. This can (optionally) by combined with a previous idea
>> and have e.g. an 'auto' state for the toggle which follows
>> MokListTrustedRT.
>
> I'm less keen on user specifiable runtime because the security policy
> of the system using a lockdown to make root less privileged than ring 0
> can't allow a malicious root to weaken it.  However, let's see if we
> can get a proposal that would mitigate that concern.
>
> Ideally, if we can get to something that works for everyone at runtime,
> we can remove the current Kconfig explosion which is definitely adding
> to the confusion (as shown in the Debian bug reports).

-- 
Vitaly

