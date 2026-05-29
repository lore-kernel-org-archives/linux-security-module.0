Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007053BAD94
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047195; cv=none; b=VNW+SPulAw3G0jUSpFwak66Lqho1xVuQnguIX+DA2QN6KhkN2vUPKGHHyoSnzEjtqMP4kALIEpjmXTPSJBEMGlaTgliKIoYDWUpHq17Ysb8b3LeKNqiFnDh/DAj3qT74N1pZ3RbxfJhdI0zgQmcVdM+pCX22s7AzoCn+X6lX+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047195; c=relaxed/simple;
	bh=oJBnS25vuN7if7mJFXm+R7eCRJTbzv2vvslR9lOBWAI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hbdp0ba2hbpNFXKYwjhsY850c0L6GV8k/bn7TyTHP+XtXgInXcFbrv1DVRj/c2KjLfwX4lsh6+DOH4j826XqaE1b6taozzpvAlOrWXOyXdjgBSXJIoDZ8qcEd/U5xwmYpDPYXZoxLk8M427JVQk1/rWhNW37L5j5aj9zMYIFFjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYarOVqS; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYarOVqS"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-680308c6c62so11756789a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780047192; x=1780651992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cWB8AxuhflmNGkthEv8fqT0Ix6HH05iWrOSrTCpjrKE=;
        b=WYarOVqSKW2lzxtiGKmVxCzKFWn7AHkwuMXGMfkxylQCkjzaT7z2YHBMWrssPDBB+N
         wxMH7dHmoR0W9V3hpzN/rj2sK9KPJ5QwTn6DGRoLka7eByBlbLC83WguDymkNJsUkmo0
         z4Ma4VuqgES7xkzC2JqRGH+tOhP9HuqBCxck0Cir2IUy+zvzuezEXlu1Z8X+Q3J3Co0z
         wH3VmnstCLsaRM8jLFG2mpW7HK1ST75zxPDYYi+r+2Hov9zac2JQ3nqWTKCyzbEHuMKf
         i2cjmHx/sWhoZvwGmwpW82MNWArO12V4eAMxmIU18XTpbj953mDg9qo0/UR8D+xKNeC/
         +70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780047192; x=1780651992;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWB8AxuhflmNGkthEv8fqT0Ix6HH05iWrOSrTCpjrKE=;
        b=ll5Lv8/HL0yRrEVb95+Q1o4yn0IJlLU/4W6I8+AQ05NIO24zZQoJFKygFBwsvrDUBk
         SF4dsPrvqkK29HXdIJbyTCu7rr7QUVGOIjCRGpzz2FbRb6du58YVbyRawbKid2gZHx2Q
         97plFUcixZSFzx/eVpQXv7iwd3wPhzrV4NWkcYClODIctYW8GFEqgaP4669kFQUOmjV3
         hQmMdYfsXPrEpM2KHgBrrbtTvtKaEjZ9n7JBtftUCUbi+CHS4rGlufkaghZvIQTjKgMd
         95S0BaBfmriMc0yEMleWJxDZRKI66UfCKtHNJOb5nkFNft60J9pbVR13T2AmzSOzy+uQ
         J+2A==
X-Forwarded-Encrypted: i=1; AFNElJ+cAcnxZKaHSbxZ8dpegUhkmuxaVQPUjsLbWt1MvzsaB55BXe+dpE1KNgnJjCTg/wJYl2+mslyFMhZ1i7yjKmug/yD63g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTVygwYhwNxS7ZAK2FQA15GpdKHZPKxN7g1QuxDPB/dFeSUX5D
	rarbP9rPkmSIUZXEG1V/TUoj0oyRzSSbapx4AjFnHi5QqYf4IpQGjJRQdvl+MAWdio92+wy/6ru
	fY+25NC3UBCLgmXdbUg==
X-Received: from eddf19.prod.google.com ([2002:a05:6402:3553:b0:68b:6e75:543a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3783:b0:683:c39d:4da9 with SMTP id 4fb4d7f45d1cf-68c11361896mr1067288a12.25.1780047191812;
 Fri, 29 May 2026 02:33:11 -0700 (PDT)
Date: Fri, 29 May 2026 09:33:00 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAExdGWoC/33NzQ6CMBAE4FchPbtmu/x78j2MBygLNgrVFhoN4
 d0FPajReJxJ5ptROLaandgEo7DstdOmm0O0CoQ6FF3DoKs5C0JKkGQOllvjGfrCHYEHXYHMOSo
 RS+aSxTw7W6719UHu9s9s+TLMcv8qD9r1xt4et14u7Z8HL0FCjhEmmFHCmG4bY5oTr5VpxaJ5e hMo/SHQIhS5yrDIiMvkSwhfQoy/hBAQKK2J6jCMFakPYZqmO+919ydKAQAA
X-Change-Id: 20260219-remove-task-euid-19e4b00beebe
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=oJBnS25vuN7if7mJFXm+R7eCRJTbzv2vvslR9lOBWAI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqGV1Sao7MrLYahIMOWG7jT0fWqoePyPKo4J17C
 p1zE3aGxWCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCahldUgAKCRAEWL7uWMY5
 Rmi1EACOyB448LMR7/KyCIEQvFcWXStiVk3Q1yU/7O6vayGXczY4d2ulBrgFHzJc+Kyh+voTWfz
 FGw/Sf2Y/IwmioZL8MSDA9Fbv4Dy2ew5/iXB02+cGa+olrN9UT7T231nhSZJrkyE8gFCV8iw4xX
 +hKKxJd/COEkktGnNWXbwHsnBSrxoWYIzbB0nKftKE3YLbGlTC3koTPNCHgiycLrEvbuEuIvqiK
 rRl1DQXQrEaQeONY6vobUrMRhiuEie+WBVzcL90jQBdtzg6nVeu+w/M9KHPnzS8U5OAE51qFx3H
 ON5t+XRIEtkjEZbS+LnBfBaNt4DHB8W4tzLXkljgEPSh1SPFm7RqWRXYjQz0YRFvWNtaA2Rq9ds
 /vj3VLkk1GVkWfcmI27JEU4j5ZcsMu4zYhDabVEIkcPZpEs2EO9krx4M7YiweOnCStQEuHQMdjY
 VUsNyRIMNmeZhfFZaUFIrL1+TfARXKuYFPXkHLGQwb+HGnikDafZfxSV9M9tXYZ05gxL45mE7rO
 +qrpOJbGhsH1r6GIxMb+fJfSH7mDk4zvVSsgmrAfYDfQ8C1uwWA8UX+J2DvLek3iCs6C44x1b9j
 8CMtPsT/nP95t4/+EeIFqSgQlY+XOByStFOh/32g6fMeICdFcGYw9lHTwmHmtSXIUyE2dX6+cv3 2cymArrf/j11c8Q==
X-Mailer: b4 0.14.3
Message-ID: <20260529-remove-task-euid-v4-0-07cbdf3af980@google.com>
Subject: [PATCH v4 0/2] Delete task_euid()
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The task_euid() method is a very weird method, and Binder was the only
user. As of commit 65b672152289 ("binder: use current_euid() for
transaction sender identity") Binder doesn't use task_euid() anymore,
so we can delete this method.

My suggestion would be to merge this through the LSM tree.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v4:
- Reword 'euid' -> 'effective UID' in 'Kuid::current_euid()' docs.
- Link to v3: https://lore.kernel.org/r/20260507-remove-task-euid-v3-0-27f22f335c2c@google.com

Changes in v3:
- Include 'task' clarification commit in series.
- Rebase and resend.
- Link to v2: https://lore.kernel.org/r/20260227-remove-task-euid-v2-1-9a9c80a82eb6@google.com

Changes in v2:
- Update translation as per Alex Shi.
- Pick up Reviewed-by Gary.
- Update commit title to use cred: prefix.
- Link to v1: https://lore.kernel.org/r/20260219-remove-task-euid-v1-1-904060826e07@google.com

---
Alice Ryhl (1):
      cred: delete task_euid()

Jann Horn (1):
      rust: task: clarify comments on task UID accessors

 Documentation/security/credentials.rst                    |  6 ++----
 Documentation/translations/zh_CN/security/credentials.rst |  4 +---
 include/linux/cred.h                                      |  1 -
 rust/helpers/task.c                                       |  5 -----
 rust/kernel/task.rs                                       | 11 ++---------
 5 files changed, 5 insertions(+), 22 deletions(-)
---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260219-remove-task-euid-19e4b00beebe

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

