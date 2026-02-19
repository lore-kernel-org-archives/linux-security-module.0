Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591903271F0
	for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511240; cv=none; b=rwRZH9pH0vSiRAfqu7D7Lo3Yau6ejYRg9P0hg6SECNAth14Nc7wqatmnblp+NYmdh8f5R9/aWfkmfiuZac4AP4P1yqBUCVdTF/03E1GiV4h/SVlVP/ZYj35UCmreHBs206fF46u0S2cftmfd9lMmg3clqPcS1s1xeAoUKBS8Y2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511240; c=relaxed/simple;
	bh=fFFjkseekXvGYoGHHkDvbbj+CFQfCypI5+YXQEHeZys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jas4zSZsR2SmP8A4ZRwNKVYf+gaW6yKh0wjMsVdt6oniXQkZ0n4g4N3TaGanWUv5YEuije4hvQUwAA82QTCYvEcDsbRekUkYjcgsfrfOA/qTlcgB2deT+p8m784w0DGmUmtqyaCcWacm4kgvMYsxUMAarwuK3k5kL4+RWBhnUG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTKJYUCu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTKJYUCu"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aae146b604so6679385ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 06:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771511239; x=1772116039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUt8gjFDI6W7zJiz3u2Nn1UdNatjAJ3oKKX8MoonuYU=;
        b=mTKJYUCugpcn5L5mDXdK+YRi2UNxKjfLhPZDzkq9uL2gWuXt5GfBk+YRqBoCvSizv7
         T0ZzF0FqkaNIbu43klTvaVMV32XKzclXitql0gtOptcBXs7XggysZRWE62OR1VtS9c+D
         xsKr/L+2M9oz/lxvYf6HHScQb9piufGqG8lHKyHiyVzFJXoCb8+WB7WY5fLWtR6pwE3G
         feGKgcVqrcwm7tL7NSSjf8r7myNfNU8hsp3WIwSWe2h0GfZ8PuHW9Fy3rs9A/DrYYEUs
         fY3UwTUZzkJLE4GUZFgbWwlF3dYd1dEsKPy2DoyMUan8pYYIKR9r1uE0ARa/zVxECMyv
         +SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771511239; x=1772116039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUt8gjFDI6W7zJiz3u2Nn1UdNatjAJ3oKKX8MoonuYU=;
        b=FzudI18Pb7OIHJDcw93rxbgRMgTCxuqY4sHS1Xz1gi4GDDOtKgGnsNFgVc1EWP4NoE
         hK13u0yN7Y8z4xTkwAP8OjNvV46uz51MpT3duBohxocEAY0UhuCKPjXYhshduNuBWGWN
         WETws5rG/RUJ825ciPuccY1fbPec6FPNhCWqKwz0xCkB2ZZCpfLb3nT+K6w0OQEiaJQd
         3oft8Bc5KZYqkB4Imup1dyfbrZg77l7Lk61Hvc00srzPZLDJfkIGrUXkrKSfliiLWj6T
         /HrY3zMWjMFR1THJijYkMvtbQeOXvNMUb/U/UUb7dQGfcgs1idCPAl9rrXgMs7vbnOGU
         oGkA==
X-Forwarded-Encrypted: i=1; AJvYcCUVgEWMW9Nw294MpZNquFSGwOlaud5xHhMEJhn30LxYpDkuNU+x8Um5YE5jGOzmWUkUV3k4i4mJcMSkyk7oCHbN/XMf4sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCbIQoYKVvOdaQdJmi0ghDLL/N1DDE+dYtFwnI/62nHc4+JSTm
	fabZszRZdlKzjP4x5wq8+94drht07dgog3/UUwYjj7soZz7ReG3tP8a+
X-Gm-Gg: AZuq6aL/DGO8XtZU3h//lpUL/19nCdjUV7C7q8G4oO3sGUD3FxH4uPTNbnIwxWo1799
	6nuWyvRxZW0DDUGWtX9xD1wYQTtUhe3efDnUlug+q0qBPTngktaVwud+YEbNBNQB/jLbJwo9TZj
	FESwI+CdohPh7RfffvgJI91lS1/YE2J6a938NaUKuvbBzsW4zVlS7a9qC0oWxyaW3osbkEOZxKB
	KcKGjZ/hfrodkZccpeuABqAGQk+YrOqEqtvAzpEuDqpq4BTmYpt8MNnG+6wEvfBytjre22J1MXe
	7TImycgvBTahu++Ck5aMvngK5NXk5iFYXNDVANwOh1P1T8Zzt1Hgdz5NUzq2V41nqosdUvU7PQy
	CJMW+O2PE2fsERvlNQ7Elh+SpJsCFdwYF382Xdl8r54hvhIkkP2wfXFs5DIFJqj6PNr6RqDhnNL
	c6Q7azi7wmou3XBXcH8qi3NbCDgOlNzXpvkAa6hEnYzSgfWmjE5bn/aAEB0txmTnAt
X-Received: by 2002:a17:903:388c:b0:2a0:d636:71e7 with SMTP id d9443c01a7336-2ab4cf7c628mr180445875ad.13.1771511238647;
        Thu, 19 Feb 2026 06:27:18 -0800 (PST)
Received: from ?IPV6:240e:38a:19d2:ad01:4c90:983:b066:e0db? ([240e:38a:19d2:ad01:4c90:983:b066:e0db])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5c4csm166275275ad.53.2026.02.19.06.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 06:27:18 -0800 (PST)
Message-ID: <c2b65a8f-b0cc-4bba-8ef9-7a079314d52d@gmail.com>
Date: Thu, 19 Feb 2026 22:27:01 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] task: delete task_euid()
To: Alice Ryhl <aliceryhl@google.com>, Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, linux-security-module@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Jann Horn <jannh@google.com>
References: <20260219-remove-task-euid-v1-1-904060826e07@google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20260219-remove-task-euid-v1-1-904060826e07@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/2/19 20:14, Alice Ryhl wrote:
> task_euid() is a very weird operation. You can see how weird it is by
> grepping for task_euid() - binder is its only user. task_euid() obtains
> the objective effective UID - it looks at the credentials of the task
> for purposes of acting on it as an object, but then accesses the
> effective UID (which the credentials.7 man page describes as "[...] used
> by the kernel to determine the permissions that the process will have
> when accessing shared resources [...]").
> 
> Since usage in Binder has now been removed, get rid of the resulting
> dead code.
> 
> Changes to the zh_CN translation was carried out with the help of
> Gemini and Google Translate.
> 
> Suggested-by: Jann Horn<jannh@google.com>
> Signed-off-by: Alice Ryhl<aliceryhl@google.com>
> ---
> Depends on these two changes:
> https://lore.kernel.org/all/20260212-rust-uid-v1-1-deff4214c766@google.com/
> https://lore.kernel.org/all/20260213-binder-uid- 
> v1-0-7b795ae05523@google.com/
> ---
>   Documentation/security/credentials.rst                    |  6 ++----
>   Documentation/translations/zh_CN/security/credentials.rst |  6 ++----
>   include/linux/cred.h                                      |  1 -
>   rust/helpers/task.c                                       |  5 -----
>   rust/kernel/task.rs                                       | 10 ----------
>   5 files changed, 4 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
> index d0191c8b8060edb7b272402c019cff941ec22743..81d3b5737d85bde9b77bff94dfb93ed8037b2302 100644
> --- a/Documentation/security/credentials.rst
> +++ b/Documentation/security/credentials.rst
> @@ -393,16 +393,14 @@ the credentials so obtained when they're finished with.
>      The result of ``__task_cred()`` should not be passed directly to
>      ``get_cred()`` as this may race with ``commit_cred()``.
>   
> -There are a couple of convenience functions to access bits of another task's
> -credentials, hiding the RCU magic from the caller::
> +There is a convenience function to access bits of another task's credentials,
> +hiding the RCU magic from the caller::
>   
>   	uid_t task_uid(task)		Task's real UID
> -	uid_t task_euid(task)		Task's effective UID
>   
>   If the caller is holding the RCU read lock at the time anyway, then::
>   
>   	__task_cred(task)->uid
> -	__task_cred(task)->euid
>   
>   should be used instead.  Similarly, if multiple aspects of a task's credentials
>   need to be accessed, RCU read lock should be used, ``__task_cred()`` called,
> diff --git a/Documentation/translations/zh_CN/security/credentials.rst b/Documentation/translations/zh_CN/security/credentials.rst
> index 88fcd9152ffe91d79fc10bfc7b2a37d301b4938a..f0b2efec342438b81be415dc513622c961bb7e59 100644
> --- a/Documentation/translations/zh_CN/security/credentials.rst
> +++ b/Documentation/translations/zh_CN/security/credentials.rst
> @@ -337,15 +337,13 @@ const指针上操作，因此不需要进行类型转换，但需要临时放弃
>      ``__task_cred()`` 的结果不应直接传递给 ``get_cred()`` ，
>      因为这可能与 ``commit_cred()`` 发生竞争条件。
>   
> -还有一些方便的函数可以访问另一个任务凭据的特定部分，将RCU操作对调用方隐藏起来::
> +有一个方便的函数可用于访问另一个任务凭据的特定部分，从而对调用方隐藏RCU机制::

LGTM.

>   
>   	uid_t task_uid(task)		Task's real UID
> -	uid_t task_euid(task)		Task's effective UID
>   
> -如果调用方在此时已经持有RCU读锁，则应使用::
> +如果调用方在此时已经持有RCU读锁，则应改为使用::

Please keep the old version. the new one is a bit ambiguous.

Thanks
Alex
