Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793949168;
	b=hzyzp9srGjtiZSKIn950xZ/YkzPziKIsY3179WgQicPEYCSuUp9M62eO5aLMMS4+1LGr
	 VwJBDXTFs76KNzHqPPE9//IX6GgqF8eisTBMAluO1iqRPyo09x5NjVX0xxfzCNQB9fJ+w
	 XbxVD/AHJ+zYaxL8W5aTLldM+sgz74qIkCavPUnshyoqvoi6GnqOom/P1W0ouYxizp8pD
	 /4Hz/hLXEx0yWIW1pWpbqfzhKoqYIITv2LYpUBR7G22xztRn2gaUbVwKhBbxXSN0lBf8B
	 RsoqgyfFxp9z6Pjrmqmyuv7TiXbO58d+9H+sjBdYomGiYVcUlcy2dgKM5dZUvVRf47Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949168;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=G5GTnL0QSwgRvtZJewk41VvHRXskbxubvuaGSLU0AXY=;
	b=XG7k3C1sKQIbbCMIOgI3ye4jnChgc2oywky73g2fRoHdfM/UMdNoqg6FP3opZbWbiWue
	 ravdstLuJPIEr8120mKhXWhd+ZJUGpzGgYBCqgvnsTLH9J2EmC0tcOJtNmJgXMfMCX7dC
	 jbDQPDaY20s7qkEtSX77zERYsW8Iu/NLEpj+jqLDZzIDrMTs5msgRaIliAsKuYoTQuRiT
	 egoNjRSBRXs9dbRqU6uIYLnpxPcKinPTuPtR41Q3eHxj9zbT1FxmpNCliAJ9ykXwZl08p
	 EgR+OUBf27xgMfEVsxulrSy/QMUwpHKYvdtVpkmgY97TxYZqF/3KpMDVXDSgHPMl74g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jD7YYdyS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786A5606A328;
	Fri,  6 Nov 2026 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jD7YYdyS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793949168;
	b=LDAJYbAs/gVZ6ToizZ9Bll8Fj1klc9XUSwaxU93v5Raq9s06mIDs68/7emViQ0nKSboG
	 wqyUyjUHE2US/4l1scWZJ0EUzvF94eL5LHm+OF1YTh/FtF5M++BXjceDwF8zhO9WNnEqw
	 LCDjk3jvr7v6TL7sR0QNGM6PxDnicuKPVxnNcXAnXJ8h8roWdiYZytUcNhUGQZw1svM6P
	 lt3d4iW+p7PgFBT0j316UoagCAfuIIY8yz3BJnWZKJLI4XKRzms6WKzVc6Uk0r8Ila9i8
	 5UzIjMjN0H++vOuQmV+6hrfWURLp+06t+5WaR8Rzdj20aUpdz+isugbyQv8ZOur2K5Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793949168;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=G5GTnL0QSwgRvtZJewk41VvHRXskbxubvuaGSLU0AXY=;
	b=FD5GKt5LuXGBb9/YpaEAcIDGEGg6b6SCz4+g6/+p04bWYIHdOwXPsa73rx9wq3JXu0/K
	 g/H7GSjUoCIZxNq9qg0IxId6jwGeQ1m3U0Fh0zz69rIqyLhWI5utgaSfcl1uoCltwehjd
	 XMGZP0PBCs/MBZwf42yqLD9ewho9QUmrCiH/S0Q5i5lOkn5bQDzobY0hfbIyO2lS85hq0
	 5J+9pG1NXX9vMpQz4X8QYC0A+NypTA0V3qbDDOHC8/7zZcKPAI5in+QHBoYyxSdEtVlN9
	 a5wwGYUBr6nRQlprhFbRH8LgT78Q5YXawKogP3+w4azKv1Kw8hrTWJb5mRBseqmttUA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1D3341F008A1;
	Fri,  6 Nov 2026 07:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949168;
	bh=G5GTnL0QSwgRvtZJewk41VvHRXskbxubvuaGSLU0AXY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=jD7YYdySMsTYm/P0V/VkUDXbq0fOBZOqVZGaSAUc4qhCEFrrjvCpn5Qtkx0gDN+l8
	 7765ox+qspA/ywXW1OmqNkBCJkMmQPfNNibgwsIEGfLEDIY3iATq8fh7Hl7Yq3b848
	 138UKedaEmIIho5YN4OHQgxSbLnqksFdGqS5D/YAcJ4fhAJ0NSCrmDqahC9OwPZW10
	 DlXIZAT8cy1Ki3LcUzzJWpw6jZyECaHfS1P3QnW1SFZNk6n5JatQM/jQREF//1iGsp
	 RkMF6OubF8AMD3xfMfPwzYqfxrrwWMSn8c/RPgAq2Dr+mM+I/vBwkdo5oanXEYial/
	 RonS9FdbK+/BQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6913B45C33;
	Fri,  6 Nov 2026 07:12:46 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Subject: [PATCH v5 0/3] pidfd: Add task path ioctls
Date: Fri, 06 Nov 2026 15:12:20 +0800
Message-Id: <20261106-pidfd-get-paths-v5-0-3147ce6571cb@black-desk.cn>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23R207DMAwG4Fepck1QjuvhivdAu3AcdwtjbWmyC
 jT13Uk7NE10l5acz87vK4s0BoqsKa5spCnE0He5sC8FwyN0B+LB55opoXaikjUfgm89P1DiA6R
 j5LbeGeEr9JKI5VfDSG34XsX3/a2OF/dBmBZm6TiGmPrxZx05yaXvT1dio0+SCw6oicgIob19c
 5+AJ+4pnl6xY8uEST0YWm4NlQ20NcEOlHSlembouyGFfLKHzkarjDVGOOW0eGaYB0OVW8Nkg1T
 ewpSksd78Zb7FNdLXJd8h3TJkDiJx7M/nkJrCS23BGauhzHmANrUWznuQ1BrnsQJsASuxXuJ+v
 6b4t1OCeMqpIsXIXVmXhC5nB6bJ59jP8y90/dO+FQIAAA==
X-Change-ID: 20260819-pidfd-get-paths-59640d8cd1ee
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org, Chen Linxuan <me@black-desk.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4196; i=me@black-desk.cn;
 s=20260831; h=from:subject:message-id;
 bh=wgKnE8AT6zpqmdbQXKjfkpLb58iWgrFhxz3SEzzfreA=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBq7X3o6Ky5NtuZHI7eJbXQEVN+9Nq8XbqFkVBdO
 8jaSwhvpUSJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCau196AAKCRB2HuYUOZmu
 i09oD/9d2F1RAOVF0ehGGa3AE4njnpiPsiT80fknzuhT1hJ7a67xlavnz4/+JAWndScNFA9E/48
 tx6ItTLkqhPIWwmjIvmQVrNG5+JBVoX0E7KwAU+/I38w3r4r3Kv8kUrxsAtjRXSKvKY1MZeg0E1
 GI7FUxgc8VX2zrmfJqR4CfT0IyEPp4FRJ39rxM5whQFfVsMx7Nt5kgfvVG0wK6D9s7kfzfuICPw
 odaxYeCSLDor6nuvxEoonHOw6LCsWaOezdl9vtHcchQj/BYbp8Uv0XWj7lbzdTNmTwWG4oxxzV/
 BuXIHcgkznW+xvBlEKt7RvsmURt6Vv5iE1wh5l7dDZZw8gLKzGkq6QeKnvdhCyoXKNkGIj2KIgo
 l/GkyZD4ysSXUl47gVsSye6noyB2H5u+OTojO1COV+0YvsH4Je3eplF6BazgbcaqlS9CziVgRRw
 vUd3RfL4ptcVxwKg1nhBebybrE3EkgHlfg9q0nP2UnefKX2WB/nk6cChGivjOHge4fuppyLrB4u
 xrWdja/usdKvVQ6y1Ot3INkX5s6Md7A4znqNZEFM7gHv5eHP/Yc/xGanTUFS/X5rHztkGPwva6s
 Gp2qWU/r09zcUxpOZqYTHJa+5smlNTQUey5kqx5F4LpNpoXgm6ZShEKkuDqDKE2czYXDHmcnq82
 DZJFI4vAMkaG1KA==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/20260831 with
 auth_id=991
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn

Obtaining a target task's executable, working directory or root
currently requires following /proc/<pid>/{exe,cwd,root}. Add
PIDFD_GET_EXE, PIDFD_GET_CWD and PIDFD_GET_ROOT so callers holding a
pidfd can obtain these paths without requiring procfs to be mounted or
visible.

Each ioctl takes a zero argument and returns an O_PATH file descriptor
with FD_CLOEXEC set. Targets must be visible in the caller's active pid
namespace. Reuse the procfs path getters and hold exec_update_lock
across PTRACE_MODE_READ_FSCREDS authorization and path acquisition.

Following Christian Brauner's review, use a dedicated task_path_open()
helper after releasing exec_update_lock. It calls ->d_weak_revalidate()
with flags zero when the filesystem provides it, propagates a negative
error, maps a zero result to ESTALE, and otherwise opens the path with
O_PATH. This gives filesystems such as failfs the opportunity to refuse
an O_PATH descriptor without starting a pathname lookup.

The first patch factors out the task path getters. The second prepares
scoped task access for the pidfd ioctls. The third adds the three ioctls
and task_path_open().

This series depends on the separately submitted pid-namespace visibility
restriction:
  https://lore.kernel.org/all/20261027-pidfd-task-access-v1-1-d46cf0fa4ca1@black-desk.cn/

Tested with virtme-ng.

Sashiko AI review reported the missing weak revalidation in v4.
This entire patch series was generated with LLM assistance. I defined
the requirements, guided the implementation, reviewed the changes, and
made the design decisions.

---
Changes in v5:
- Add task_path_open() as suggested by Christian Brauner, replacing the
  direct dentry_open() call from v4. Revalidate with flags zero outside
  exec_update_lock and return filesystem errors without lookup retries.
- Link to v4:
  https://lore.kernel.org/all/20261027-pidfd-get-paths-v4-0-e2a6a47e3c95@black-desk.cn/

To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Ben Segall <bsegall@google.com>
To: Mel Gorman <mgorman@suse.de>
To: Valentin Schneider <vschneid@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
To: Kees Cook <kees@kernel.org>
To: John Johansen <john.johansen@canonical.com>
To: Georgia Garcia <georgia.garcia@canonical.com>
To: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org

---
Chen Linxuan (3):
      fs: Introduce task path helpers
      pidfd: Use scoped cleanup for task access
      pidfd: Add task path ioctls

 fs/fs_struct.c             |  44 +++++++++++++
 fs/internal.h              |   1 +
 fs/open.c                  |  30 +++++++++
 fs/pidfs.c                 | 157 ++++++++++++++++++++++++++++++++-------------
 fs/proc/base.c             |  34 +---------
 include/linux/fs_struct.h  |   3 +
 include/linux/mm.h         |   1 +
 include/uapi/linux/pidfd.h |   7 ++
 kernel/fork.c              |  22 +++++++
 security/apparmor/task.c   |  12 +---
 10 files changed, 224 insertions(+), 87 deletions(-)
---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20260819-pidfd-get-paths-59640d8cd1ee
prerequisite-change-id: 20261027-pidfd-task-access-b797ecb260a4:v1
prerequisite-patch-id: 021f6b0840ced7fe967a849b99c366257160c005

Best regards,
--  
Chen Linxuan <me@black-desk.cn>


