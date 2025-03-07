Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE0F2580DE;
	Fri,  7 Mar 2025 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385040; cv=none; b=M5UsvYLo/3djCNkrISZ31VVCKFAaw4CnKCEJM8PxGvQKH636g/LoRWax/6XVZ87Scq5iBiW814imdPSJ6ut19yDfPiCSZ4RlgGvwDJr5OnjqNQ8WFl7XMVaTiX5PO+rIyc5RdBPLqE1Kq4qmjr1w8xN3LppAvwDwc1KhBYuUXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385040; c=relaxed/simple;
	bh=JPnc25OT31Ab5OA7MLwFfd7k805GfDNT0ZgWCR8SxOI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RFVLqp+bvch8f7TtTRM2vBQzIgqie/4dvoeuC2aKGOoIwm2ha9l1ELrJ7+o+uQqTmdedVROF5Zhxy1tnf8uEHjuo41eYW0ik43Oa+fH2cZkQzbsWpAeeBbapOObmVqYAfeBufGeVoUpfOygazqIcdns4HxoVAa/xL52Ql0GZrS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HWf5hds1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HWf5hds1"
Received: by linux.microsoft.com (Postfix, from userid 1212)
	id C9FA521104A3; Fri,  7 Mar 2025 14:03:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9FA521104A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741385037;
	bh=lT16XPDsR04UwqlTf9Lwom2ss3+hCCwOumdIbeh1ykQ=;
	h=From:To:Cc:Subject:Date:From;
	b=HWf5hds1MM9buJtIuiWA6hLCE4dmrH4284q8CTfG8x4briqY7ieAy/Rz2GqLuBNKY
	 lI1N3HwywwD+cO7I7/kosGHAIcu1vGcdIvW8dn4W/uNPZSs9Qk4XAwQKAKRlhcf1Nf
	 1oYEqYBpl/NrYjPcnnjaEnGvBPnzkJ4TFFUMyrP8=
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
Subject: [PATCH v4 0/1] ipe: add errno field to IPE policy load auditing
Date: Fri,  7 Mar 2025 14:03:54 -0800
Message-Id: <1741385035-22090-1-git-send-email-jasjivsingh@linux.microsoft.com>
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
v3: https://lore.kernel.org/linux-security-module/1740784265-19829-1-git-send-email-jasjivsingh@linux.microsoft.com/
v2: https://lore.kernel.org/linux-security-module/1740696377-3986-1-git-send-email-jasjivsingh@linux.microsoft.com/
v1: https://lore.kernel.org/linux-security-module/1739569319-22015-1-git-send-email-jasjivsingh@linux.microsoft.com/

Changelog
---------

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
 security/ipe/audit.c                  | 21 ++++++--
 security/ipe/fs.c                     | 19 ++++++--
 security/ipe/policy.c                 | 11 ++++-
 security/ipe/policy_fs.c              | 29 ++++++++---
 5 files changed, 111 insertions(+), 38 deletions(-)

-- 
2.34.1

