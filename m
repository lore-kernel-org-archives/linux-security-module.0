Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A23876C4
	for <linux-security-module@vger.kernel.org>; Fri,  3 Jul 2026 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061833; cv=none; b=firydsjoqZ0jiV8n+9319zCmXt8oaQbl3jp6v3nWjR3JeNtxRwWYfRStg5bGFZk7YFIUbwg75mnb22uDV6Z3hk/zM+cxC6oB3CgvJATLnCu5O543v9TYJZlhJWLIDNrcN/ZCQcokbjsiVJuX5vlPWReXAEqg9SSHjxmNuH3GRus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061833; c=relaxed/simple;
	bh=nScf5netnt1NjDVQidgpbeNPyFsk+SnFXpkUx7OAXGA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RhUV+CB+hkNeatIZmwyVDX0+Stt4X/zVfp+/OiCoi+F3MRwtpFMxSXXQ/b6jD/5i3ixfvKEnczzLQxzUS+aIa4eXcl9B8DEDIGoGY6jBdXLFjjA+ZNYkMTnIxsXi0D7S3keJJHbwX1kBzwjC8Nt6Mcc/E6EbTAH+nLuwo9qBQcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c42UBbw2; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c42UBbw2"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-473f4a48e9aso181341f8f.2
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 23:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783061830; x=1783666630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BhiXOxf+bZWI18LM0Dx3pOu8Mks9Sw1XqPANu+yyKx4=;
        b=c42UBbw2vIa1ioj39shj824X91NUhmLordhn71LW1QE4VyJ9fy0jvumI9eWCuw4Ov5
         L+kuway3F7nusP5czEpWDmH91089MjzQ/N2HbLLHkL6RJBDYkzr10pN+SDDCGNQoEk7U
         2I0wPY3WeY7gT8+x15q7PUQ/sP78AyTA2zoV0EtpvcaqjkJnVwMsHuAQiJmPC9i7b8RH
         twVKlD+oyroy8NtdofK8ivEv6gxFlXnbKvnd9PGJjnhK004xUjOxSMdDeQ9qvUicZxPB
         n42mKKjjkEXHdPJQWEIL0T39RFPufhkWRG4sL23LI8fkPPsRlt/Mj3pJq0nzPw1zbwxp
         3uEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783061830; x=1783666630;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhiXOxf+bZWI18LM0Dx3pOu8Mks9Sw1XqPANu+yyKx4=;
        b=sHCS3dkQ6L2DOCD1oMujSgpFogaUQ9K9JSj3KOo2ML/sryqrbs8CfsUpquT7RbqORt
         /7LPEBod/If2Fhh0uJjXKpuJEOd3FJrTYv7FHIJl7A/0Kc5AStF+pFM1465V0CTqWdrV
         BMT+a1IJgn9Yaa/EQzHkejBh7YRJnZC9/zsP4rPM9RswVWbcgWdPCxKhAuZdv63cVuOs
         UOOtsDORs4KMEm2yl330mYitQdTv21628OMYVMXHpp6GPGl23op1cT+v8wlQmXZIi+uS
         eYMpixWvaDRO73+conuXdrlYjUQyxmZSt6Gx63cCeOaZzKQlzah3XWP41ZMxp1NfRPHG
         prFA==
X-Forwarded-Encrypted: i=1; AFNElJ+KAxSFiKrYOi46qwn5BxZswFV669RSB/9o6HJkG1g5nLAU7aGg6F0ushlctEZZ4fxw8MWC1Xu/bxJdmKg2RJzTw0CuUsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdeH+J0nVKY4Rjlzgn8G/IM5Wzha0NSgCIq251tsHOw+ISw6VH
	EJquA4ksX2kMcC6PqrCT0/AK1+goppWEeKwUOws/FCOPnA7aFdAuBY4/2Mdt8NMWRngRqklrTCF
	YJV+AWsvqVvlCh+R7aA==
X-Received: from wmdn10.prod.google.com ([2002:a05:600c:294a:b0:493:b4c4:536f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5010:b0:493:72d3:4a81 with SMTP id 5b1f17b1804b1-493c2b5161emr120210055e9.16.1783061830358;
 Thu, 02 Jul 2026 23:57:10 -0700 (PDT)
Date: Fri, 03 Jul 2026 06:57:00 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAD1dR2oC/33PTU7DMBAF4KtUXjNoPM6fWXEPxMJ2xqkFrcFOL
 VCVu+OURYsasXxPmu9pziJzCpzF0+4sEpeQQzzW0D7shNub48QQxpoFIXVIUkPiQywMs8lvwKc
 wgtTcWETLbFnUs4/EPnxdyJfX35z481Tl+VruQ55j+r7MFrm2/ywUCRI0NtjhQB1j/zzFOL3zo
 4sHsWqFbgTqNwRaBaPdgGYgtt2doK5Ci1uCAgTqPZFXqnXk7oTmRqCtL5oqYO/s6JXxesA/wrI sPwkc0nyMAQAA
X-Change-Id: 20260219-remove-task-euid-19e4b00beebe
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=nScf5netnt1NjDVQidgpbeNPyFsk+SnFXpkUx7OAXGA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqR11ApXczXX2Gek2J+6VC5z6Iuc4bHt3uT0qa3
 oQletGsubiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCakddQAAKCRAEWL7uWMY5
 RnYREACES2fWRH58RUZ8ijCGO0nid0c3qD6986tFCKqRXA2+AKL/DwrN05zSGi/BGr1Q6p9VNLC
 z6yK0MiUwXmZICs5E4UOKWBAIsAtDmwK6LfhY0ipAnISJwL8AlheQOBdgzBInbzV2/NM0d1VbPw
 Z/xhGMZtUel0kUJ9DH+Im3mT9xj3TVGD/huCvsbo5sHHH6AI1MJFFJx2pqHErUgCO69nuGG6G4x
 CCoDwoPGAYVUfxXRylBKOxEzmkSlK75dvX9YicD+GFsFNSR38F2dNlzQdYSy6I2N91gfS94Notl
 8Kha95efuMsWSKFmKZeMRUlMFF+eWUNPOB1DNl1t5oY70wcYFefpj0ffrx8gcBs2n1bUNLTOClU
 2Ii1YcOEAGsbVxxTljxttKsCT6Q0x6yq+jHtegU1CzCcTcYxZTF/OkylwoZZPWeKH1+/lsqRnja
 BqRijzyxA/3M5azKjTLdMzERNVIwAddUiD+G7Z9EtzJGr2a72A3qbDXd3heu+5IbOJvgBK1uhRH
 wXuvvJagFdu7Q7Nihky8l4pWlgDEJtlMGIQ0w7wxAf2ai7dx+fZgmLuEE3hFfBJiMVcC2lRxrbD
 Dsq+YHG1CvpCCz+g9NRM6qGl0t9Zn7cM/cFc7Fxut8hEG9+5YmlPGyFBEG4QdZagSFBK0VAS4Oh R+wqLG+8mV38XTw==
X-Mailer: b4 0.14.3
Message-ID: <20260703-remove-task-euid-v5-0-c90c7e2ddf54@google.com>
Subject: [PATCH v5 0/2] Delete task_euid()
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
Changes in v5:
- Rebase on v7.2-rc1.
- Reword patch 1 commit message to take into account that usage has now
  been removed from Binder.
- Pick up Gary's Reviewed-by.
- Link to v4: https://lore.kernel.org/r/20260529-remove-task-euid-v4-0-07cbdf3af980@google.com

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
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260219-remove-task-euid-19e4b00beebe

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

