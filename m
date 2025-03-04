Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51E1FF1BF;
	Tue,  4 Mar 2025 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132393; cv=none; b=jssrzgFr1FRhA55UrgTnJU2YlzaLOLZcjt/M2kaFYljqASmOpqE39X2V7HLUmqSk6Z+i+NFfafE3C5QymxPm3G7b3Ps3DUaTnnW0UCcdMrrW6a30MPU0FI1O153iMgF7fcohqU/9dbEBJPNoLOjkParCMAAmxFJzmoJoe8zVLfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132393; c=relaxed/simple;
	bh=DkDLUBOc3EwKu5BIq14SkZZ3shuv24GDO1QLLw4Hs+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8T7M7YrsIOMvN4q2V5GflSYRsB205+iXwsmMheYIG8c3EAzjiFxyCGA+efo+/avoth1oaKfACU7B6iM+K1U0p04zWxRQnZmJNawEEGyd7Xi/R+Wkrq1DHZ5VaOkc3+FYnb3EhcLVAcVq8G/71e8Q6yJCkFTY1VBcT/+Qy5pTQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGYKcpU3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGYKcpU3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3F9C4CEE5;
	Tue,  4 Mar 2025 23:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741132392;
	bh=DkDLUBOc3EwKu5BIq14SkZZ3shuv24GDO1QLLw4Hs+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGYKcpU3og+84iRqk3M/L1IJz5tkJOm7dbu5YilOb4MbsMY2alrsdE1jt/ovtJJKk
	 IjQIbgijnHqX4R0S0OKnnUcEbY8/KE+7U0vQqtOS8vZXrmsHKQiqQfNV56qmTdNfiW
	 PouDB4Uy/Kogo1DSa/sMhbLm393uNx7eIYj6u5fMiJ3OWDv6JDHaFxX4VzWzM7PhR7
	 PlwLubAclCB+Fqu7/PBparwv7JX6qe/2PJfEtu8DwQYjFk9X+XrD91/aaCsm8lk0RY
	 V4SlGYLgmXAB2d+dlV1TBx4vGjtTiqdysKgEVhSLHt+Vpp9Z061KVrpbwWG2yAj27e
	 ZcVSNzmExt6lg==
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] yama: don't abuse rcu_read_lock/get_task_struct in yama_task_prctl()
Date: Tue,  4 Mar 2025 15:53:08 -0800
Message-Id: <174113238769.4011875.8051227227833188142.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219161417.GA20851@redhat.com>
References: <20250219161417.GA20851@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 19 Feb 2025 17:14:17 +0100, Oleg Nesterov wrote:
> current->group_leader is stable, no need to take rcu_read_lock() and do
> get/put_task_struct().
> 
> 

Applied to for-next/hardening, thanks!

[1/1] yama: don't abuse rcu_read_lock/get_task_struct in yama_task_prctl()
      https://git.kernel.org/kees/c/c6822ed5d037

Take care,

-- 
Kees Cook

