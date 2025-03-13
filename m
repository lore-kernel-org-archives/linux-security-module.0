Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE861EA7C9;
	Thu, 13 Mar 2025 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902671; cv=none; b=G3jhcM/DssXGv2bFxuFB7ZeaufbP387Wf1ZmabB03PPociKhoqaC3ADj4qvfKWSrs0RaO+VMk0lRJXI8twMs5B6D/2kv2ysIqHGEQ+igK8GbOsn/bCtqKlAmQggooX7vTx2ap08BeLkljmxcu5LwVUlW+2DPLFqY7LxQ74xTtK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902671; c=relaxed/simple;
	bh=r8GYZdVLSHLLvs9dPvnIxJkn4vAA2uVbJuheWRdrC70=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cAxQyljo4YQGDwTU3+ZTxNQt7HvLdGAiYWmMGY0d+wcN1FswvF0YHa7f6u/47+ZmO1Cnq39/qeC2hpsC4WAtVQkNP5LqfFJ1J4dv/7uKlKOR8AEafnayFuAeRocQCiHM/kmUodfugefNTTLCCzPF81PTBFXWKgcsbM2QvNmpUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JjVFvH4C; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JjVFvH4C"
Received: by linux.microsoft.com (Postfix, from userid 1212)
	id ECF0A2033430; Thu, 13 Mar 2025 14:51:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ECF0A2033430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741902668;
	bh=DtiL37rJshdH3nDzTNYky8y+4UT+y6qABeaJMa2+kyI=;
	h=From:To:Cc:Subject:Date:From;
	b=JjVFvH4CYjQYYUTtgvPTUsar/0SHPJPdbvQ5wkYi+BcRY2kdterFycC49BBKZ35Iv
	 bYAEpyFlhBcObWw180/f6svjXpvfjwDJ3Iyvhz+wRsuCNJs7QLJgGmBMnqNftgbgyz
	 5pKhmainICM8czn7gyIY+5+Vw+K/i0ZVcGItQo34=
From: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
To: corbet@lwn.net,
	jmorris@namei.org,
	serge@hallyn.com,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Subject: [PATCH v5 0/1] ipe: add errno field to IPE policy load auditing
Date: Thu, 13 Mar 2025 14:51:00 -0700
Message-Id: <1741902661-31767-1-git-send-email-jasjivsingh@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Hello,

When deployment of a new IPE policy fails, there is no audit trail.
The failure is written to stderr, but not to the system log. So,
users of IPE require a way to identify when and why an operation fails,
allowing them to both respond to violations of policy and be notified
of potentially malicious actions on their systems with respect to IPE.

Previous Postings
-----------------
v4: https://lore.kernel.org/linux-security-module/1741385035-22090-2-git-send-email-jasjivsingh@linux.microsoft.com/
v3: https://lore.kernel.org/linux-security-module/1740784265-19829-1-git-send-email-jasjivsingh@linux.microsoft.com/
v2: https://lore.kernel.org/linux-security-module/1740696377-3986-1-git-send-email-jasjivsingh@linux.microsoft.com/
v1: https://lore.kernel.org/linux-security-module/1739569319-22015-1-git-send-email-jasjivsingh@linux.microsoft.com/

Changelog
---------

v5:
* changed audit log format from AUDIT_POLICY_LOAD_FAIL_FMT to
  AUDIT_POLICY_LOAD_NULL_FMT.
* added success case in IPE policy errno documentation.
* removed unnecessary errno documentation in new_policy(),
  update_policy(), ipe_new_policy() and ipe_update_policy(). 
* merged success and failed case together in new_policy() for easy
  maintenance.

v4:
* added a seperate errno table to IPE AUDIT_IPE_POLICY_LOAD documentation.
* fixed error code handling that happens when memdup_user_nul is called
  in new_policy() and update_policy().
* added additional errno documentation to new_policy(), update_policy(),
  ipe_new_policy() and ipe_update_policy().
* added ENOKEY and EKEYREJECTED to IPE errno table documentation.

v3:
* used ERR_PTR(rc) directly rather than assigning to struct ipe_policy.
* removed unnecessary var from update_policy().
* removed unnecessary error handling from update_policy().

v2:
* added additional IPE audit log information to commit to show the errno case.
* changed log format from AUDIT_POLICY_LOAD_NULL_FMT to
  AUDIT_POLICY_LOAD_FAIL_FMT.
* removed unnecessary res var from ipe_audit_policy_load().
* handled security fs failure case in new_policy() and update_policy().
* handled insufficent failure case in new_policy() and update_policy().

Jasjiv Singh (1):
  ipe: add errno field to IPE policy load auditing

 Documentation/admin-guide/LSM/ipe.rst | 69 +++++++++++++++++++--------
 security/ipe/audit.c                  | 19 ++++++--
 security/ipe/fs.c                     | 25 ++++++----
 security/ipe/policy.c                 | 17 ++++---
 security/ipe/policy_fs.c              | 28 ++++++++---
 5 files changed, 113 insertions(+), 45 deletions(-)

-- 
2.34.1

