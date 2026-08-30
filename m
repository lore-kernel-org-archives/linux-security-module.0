Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D798381AFF
	for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788106723; cv=pass; b=AxlKxiKEITGOGYY7j6uQ5zduAdxUpDJjPC4S9kPUiswfGNURTcijN7h8nuzbF+W0XEEDWsqkvFpRq6skQLr7B+bjhIYBPwmVNBqmGpRi0Cz6pJGrzAMJ5MI9OrcKLJBBpMh4woX/JC6pRf1tkzSlyYL6em12BTmCvSYqyZuiums=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788106723; c=relaxed/simple;
	bh=TBwTBGpfFlI00fiylz+YCziKz54brt7GCa6Ljs3wO/Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WjfUcffyuSG3uo+F+Zgnzfr7503Y0hWuzsF0vpxSouVPe6PdQpL04j8scNwZCAaZSlHtiyk2IQ7C2/gwBwEit1HeD1MZzyNMVUnZmnmmqrI3WKWEumKoHW/75XWe4aR+7iN+7Mtg62coCJLylziJC22eM31GR4R4RIv/jfDZ9zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbUUSCbp; arc=pass smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbUUSCbp"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-38fd9408220so655872a91.1
        for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 09:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788106721; cv=none;
        d=google.com; s=arc-20260327;
        b=Qf51VsdznXwAturpnwcDiI4snPrv1KksURjOPyU9FelD3DnvSFfwe1HLVioNjkryqs
         d9ZSW1abXZOPug95KIpggfUxo8sCtO3IwNtXdWX30XuhSbYOtYG1O5L9aDHQeZocMFiq
         TgRUi+jVnUGZjjDAU7AkqnOdrzx5BMNAz6J7G1ofATuoS0uqltp9jMQ90+wRfI1HBLk9
         /y187jpfk+ZdFoJWeab8XNHzB+q7Z40DNJwjGTgDpewyTk5zsX0c0AoUcoIg+hKXf8SN
         8hpl/XcJ9fNLLKNQKkSSg1OVQaTfSCoIKYBGYAK5911SyYDox19REAbMcuD/mOkVuC2Z
         Q3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YCeJLnCjujFd5Tuu3vMrdczTw5NdJBJyfaA6i4lo768=;
        fh=hKq2zdVm8v201oAqydOQFvDkxBKaGm9p5jSVGjwJByE=;
        b=qblopRpJpr6k9KoLCs/7rMPVlgFT3uVE14Vl+/24luslmpJfUFpGxbBeNv+W2VseLW
         vuKE8ve6yIELbrXct48z/NPAklpge492B5tpHiDcfVVaTfb0XX8KEUZTa+bg5d2naJDZ
         slCu5fZvHGAl/xeyKVbmyh6A9NF7pqzxZFK05EctP04/mqNqCqakt4lqtwNGPvYgd6b7
         5RmxgA4z1A0LtGSPZRrzkGKYkX7RDGr5mX34arqVQqYahaE4oV8gJwcQlZ8MGroyf6xt
         g6GaoTju5+jUe9gmg0PY7VswSGOPLW1UTUdlYco4vqKacKltsoyyAUPpji06Hy+QoC6D
         ygwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788106721; x=1788711521; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YCeJLnCjujFd5Tuu3vMrdczTw5NdJBJyfaA6i4lo768=;
        b=YbUUSCbp/SFVDe7yWaXMBv/Qfmard+uFE2dLUtkYT1DNrqdDZTCh2ovdokGr8oYveY
         M+9W04TSKEnclnnGAiNs5WTXjJijb0t3bjNKHYhMyk76xzFf+4scVobXlpiCcY+qFRJd
         hR2oqcEHVYDWm3jaH4DpsTViKEESfQLB4JJGLIzd2N2QkY5/Osn3D//UMQ9YyTLVbSUz
         lrVpmOa8P4Qkv6GJSQXhXtGfSfrhdTJ0/YpZ3Id3M0fHJhHDV0Jp2aFDytFx0TeUQU9Z
         fjfsOaSkT9TmmQ/Hwq54wjnspjSVeHHpzavplM9BywjEqgfJp91qvNv8rHa77MhNbZan
         aTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788106721; x=1788711521;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YCeJLnCjujFd5Tuu3vMrdczTw5NdJBJyfaA6i4lo768=;
        b=eQ7p5Rbo4s7LZBMMi90+8afbiYNHAYzZnJ77WdHWfUgC/EW/9C2sywWB/00twimqFg
         bg3rGMZyztWEeHUIuAxi0Lhg6BdoagSu6oQJ0tMJCVEP7GSWMJ8HFzfSiyMLC/a36OVb
         3LUMoDmUiyVVdV4zTonKMjh+rhmdjVXbszjUr0LG/sUmyQaKQOulngZ1LZPYTvmzxQmH
         bC0c6vfRFCNc95s9aor1YHPFJ2fCEstS3tcK6alUtq+pavJuivkNRe28hv4rVQx47NTM
         ls5TrvSyRPVxSZgWPtCpcQsqMIYFqQjSXPkxLwrwh1Qa4hbFD2fcTHT73w8I56Fueg6L
         2fIw==
X-Forwarded-Encrypted: i=1; AHgh+RoBnz6/guK2eud9A5gHTsqJurWntiQ0f75mJcV9EAFnQIiXoZtK4G0uYKuP4BW6uGFsev+oVQNKlnmFVZ5u4x/tq9C+Okw=@vger.kernel.org
X-Gm-Message-State: AFuF++mIL+0WGqNau8t9tiu5e74o4kBwVAz36Zml7SoMqjJEndkGLbtx
	If+B2kWmCFEKrXCr9nlKlsH24JvHY2nnYo0Z8XNmYHwI4PMwd/4iLQfiiE7JI1b2KO+wF/Osd8m
	miMUwN0Chbh7uIiUQLvmqFkGo2B1scJg=
X-Gm-Gg: AR+sD11hnRPvMXB6omYZ1D9Y+/wMgLJWSmqVg46HdVACfo1tO+4AdMi1FYRge7GvLmN
	v2dIN5m7PQE1y1uDzJ2mSgt/p91S5P4P3va6GmU5cvhs7QmFn4t9Z64xS9AzU3gu2qXh79AL9vu
	+wVAkopHVNkQfNDBMvwRxrD7AmBT10Pb1cWIGXvrN6SFyxTGFnri+37aXH1EGcpdkEK1+CNCQcp
	HMAspeGU/It6VP0jmjriRrEJfnIlMzejdqY6bGL6f/Coop39GdLBuGl1LgIuQ5sAN0jv53uXrDo
	XsvMceox9O+un0RxT5OfWM7rm9CM/DWYFC1CNb449Xm6+A==
X-Received: by 2002:a05:6a20:548c:b0:3d3:aee4:66f3 with SMTP id
 adf61e73a8af0-3d3aef46d46mr20526363637.25.1788106721458; Sun, 30 Aug 2026
 09:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yan Yanhx <yanhx7@gmail.com>
Date: Mon, 31 Aug 2026 00:18:23 +0800
X-Gm-Features: AcwNN1WKGFAyXe7WvgEf21yNbwZ63ziGc5yy72Sf2XHSiEEHCFdBg-94X-XdP5A
Message-ID: <CAMvJdVpx5C0W3wpwYCEphuHnHiv91ZqTPEjTU8Wp0iUJa=01KA@mail.gmail.com>
Subject: SafeSetID: GID transition policy lookup uses RUID as source,
 allowlist can be bypassed (setgid to any group including 0)
To: Micah Morton <mortonm@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Serge Hallyn <serge@hallyn.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Summary
-------

In security/safesetid/lsm.c, id_permitted_for_cred() builds the policy
lookup key for a GID transition from the process's old RUID instead of its
old RGID. When a process's real UID value differs from every source GID in
the installed GID policy, setgid()/setregid()/setresgid() to any group
outside the allowlist is silently permitted, and the process is not
killed. I reproduced setgid(999) and setgid(0) succeeding on Linux 7.2.

Affected version
----------------

Introduced by commit 5294bac97e12 ("LSM: SafeSetID: Add GID security
policy handling", 2020-07-16), first shipped in v5.10. Still present in
current master (08dbfad3f504). The vulnerable line is unchanged since
introduction.

Code path
---------

security/safesetid/lsm.c:

    static bool id_permitted_for_cred(const struct cred *old, kid_t new_id,
                                      enum setid_type new_type)
    {
        ...
        if (new_type == GID) {
            if (gid_eq(new_id.gid, old->gid) || ...)
                return true;
        }
        ...
        permitted =
            setid_policy_lookup((kid_t){.uid = old->uid}, new_id, new_type)
                != SIDPOL_CONSTRAINED;

The lookup key uses old->uid unconditionally. kid_t is a union of kuid_t
and kgid_t, so for new_type == GID the numeric value of the old RUID is
reinterpreted as the source GID and looked up in safesetid_setgid_rules.
The guard in safesetid_task_fix_setgid() (which decides whether the process
is constrained) correctly uses old->gid.

Consequence: if the old RUID is not numerically equal to any source GID of
the installed policy, the lookup misses and returns SIDPOL_DEFAULT, so the
transition is treated as allowed. setgid() to any group - including gid 0 -
then succeeds without the intended SIGKILL. This defeats the GID allowlist
that SafeSetID is designed to enforce.

Reproduction
------------

Environment: Linux 7.2 (v7.2 tag, kernel.org), CONFIG_SECURITY_SAFESETID=y,
booted with lsm=...,safesetid.

Deploy a GID policy that allows exactly one transition:

    # echo "2000:100" > /sys/kernel/security/safesetid/gid_allowlist_policy

The policy means: from source gid 2000, switching to gid 100 is allowed;
anything else must be blocked.

Then, as a process with credentials RUID=1000, RGID=2000, holding
CAP_SETGID:

    setgid(999);

Control group (RUID == source gid, so the bug is not triggered):

    RUID=2000, RGID=2000, CAP_SETGID, setgid(999)  ->  process killed
    (SIGKILL, exit 137), as intended.

Buggy case (RUID != source gid):

    RUID=1000, RGID=2000, CAP_SETGID, setgid(999)  ->  succeeds (exit 0)
    RUID=1000, RGID=2000, CAP_SETGID, setgid(0)    ->  succeeds (exit 0)

Both out-of-allowlist transitions succeed when the old RUID is not a
policy source GID. A minimal reproducer program is available on request;
per the reporting guidelines for AI-assisted findings I am not posting the
exploit source in this message. Say the word and I will send it privately.

Fix (tested)
------------

The fix builds the policy lookup source from the GID when the transition
is a GID one, and keeps the UID otherwise:

    permitted =
        setid_policy_lookup(new_type == UID ?
                            (kid_t){.uid = old->uid} : (kid_t){.gid = old->gid},
                            new_id, new_type) != SIDPOL_CONSTRAINED;

I built this change into Linux 7.2 and re-ran the reproduction:

    before fix:
      RUID=1000, RGID=2000, setgid(999)  ->  succeeds (exit 0)   [bypass]
      RUID=1000, RGID=2000, setgid(0)    ->  succeeds (exit 0)   [bypass]
    after fix:
      RUID=1000, RGID=2000, setgid(999)  ->  killed (exit 137)
      RUID=1000, RGID=2000, setgid(0)    ->  killed (exit 137)
      RUID=2000, RGID=2000, setgid(100)  ->  succeeds (exit 0)
[allowed, unchanged]

The out-of-allowlist transitions are now blocked and the legitimate
transition still succeeds. scripts/checkpatch.pl reports 0 errors,
0 warnings. If a proper patch is wanted, I can prepare a git
format-patch with Fixes: 5294bac97e12 ("LSM: SafeSetID: Add GID
security policy handling"); the change above is offered as a starting
point for the maintainers, not as a submission.

Impact
------

Deployments that rely on SafeSetID GID policies to confine a CAP_SETGID
service to a limited set of target groups lose that confinement: the
process can switch to any group, including the root group. This is an
authorization-boundary bypass limited to systems that explicitly enable
SafeSetID and install a GID policy; it is not a privilege escalation from
an unprivileged context on a default kernel.

Best regards
