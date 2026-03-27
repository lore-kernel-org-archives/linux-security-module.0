Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19F33F8B1;
	Fri, 27 Mar 2026 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634065; cv=none; b=QRljlCpuje2Qr7y4NpRXUM2advWiN1UO2fVs2V8BwNK8gnedxAuFqArqgf1+RwC/gkxcd2ehI6NoIHlY2VKTTwGn2ulIecmwCZPgowPs3j1tGd7i0+SwfFvuZCjgEvEtyWw5ObYFBcQSjVzvqq26S6HncTaXd0VGHVBYk9UUvMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634065; c=relaxed/simple;
	bh=xT1Z1Xf1nId1mNV7McJTlqqXVZzT5JJypn9FsrQ2Sgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h9mtSb6xgxRqT8b9i2gMYkpm/Fd2qND+5IMF9HF+kuUVYxqpxe+Ee2TcNl69WkxTxqeTpqGGQO7SrRv/dZuToczjWHaRIpV+WF/yQWj5NRQ3TcL5DSMfYwfT5rsCSV2G8S1RHb8Vw9cyH0H6L8aKbfV8N+7q5aLKFUz6mbXExEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NVItzwWY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NVItzwWY"
Received: from narnia (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1209F20B710C;
	Fri, 27 Mar 2026 10:54:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1209F20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774634058;
	bh=p1OrZTY/b5umyuYKNTIPKtE8SHUxFqRbAaccKYQolvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NVItzwWYYnXqhvhWgOG/iUkc3jaID3YT+OmGT50Uvokju1zf+EtUkzzmbD2Ixy/TI
	 SJ0UafXZpAQdWEfJlziYubNtu/71f0XTmLM90y03wfNO1NR/zExjX+z32rSi8AzArT
	 kzhuZybx6aX0xb77l8lqd79uzOAdJSdAhlpETy2c=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Song Liu <song@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BC?=
 =?utf-8?Q?nther?= Noack <gnoack@google.com>, "Dr.
 David Alan Gilbert" <linux@treblig.org>, Andrew Morton
 <akpm@linux-foundation.org>, James.Bottomley@hansenpartnership.com,
 dhowells@redhat.com, Fan Wu <wufan@kernel.org>, Ryan Foster
 <foster.ryan.r@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 4/9] lsm: framework for BPF integrity verification
In-Reply-To: <CAPhsuW6P-K=nTPxBk0_Wd0E1wDCBqb=uUQzmzpEg2NJub=L+dg@mail.gmail.com>
References: <20260326060655.2550595-1-bboscaccy@linux.microsoft.com>
 <20260326060655.2550595-5-bboscaccy@linux.microsoft.com>
 <CAPhsuW6P-K=nTPxBk0_Wd0E1wDCBqb=uUQzmzpEg2NJub=L+dg@mail.gmail.com>
Date: Fri, 27 Mar 2026 10:54:16 -0700
Message-ID: <871ph5f99z.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Song Liu <song@kernel.org> writes:

> On Wed, Mar 25, 2026 at 11:07=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> [...]
>> The first new callback, bpf_prog_load_integrity(), located within the
>> security_bpf_prog_load() hook, is necessary to ensure that the integrity
>> verification callbacks are executed before any of the existing LSMs
>> are executed via the bpf_prog_load() callback.  Reusing the existing
>> bpf_prog_load() callback for integrity verification could result in LSMs
>> not having access to the integrity verification results when asked to
>> authorize the BPF program load in the bpf_prog_load() callback.
>>
>> The new LSM hook, security_bpf_prog_load_post_integrity(), is intended
>> to be called from within LSMs performing BPF program integrity
>> verification.  It is used to report the verdict of the integrity
>> verification to other LSMs enforcing access control policy on BPF
>> program loads.  LSMs enforcing such access controls should register a
>> bpf_prog_load_post_integrity() callback to receive integrity verdicts.
>
> bpf_prog_load_post_integrity() is weird. Some questions about it:
>
> 1. Is it possible to call it from other LSMs (not hornet)? Specifically, =
is it
>    possible to call it from BPF LSM?

There is nothing hornet exclusive about that security hook. If the BPF
LSM folks wanted to use it they would probably need to implement a
kfunc to invoke it.=20=20

> 2. This set does not include any LSMs that attach functions to
>    bpf_prog_load_post_integrity. This is against the new LSM hook policy.
>    I guess the plan is to add LSM users in follow up patches? Could you
>    please include at least some of such code in this patchset? This will
>    help folks understand the use case.
>

Sure thing. I will be sending out a v4 with additional patches that has
a concrete user of bpf_prog_load_post_integrity.

> Thanks,
> Song
>
> [...]
