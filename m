Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5E23D3327
	for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951214; cv=pass; b=XOwnPjilX2PsANDu3wEX0GS9BZ/tE2qZOVitr6bEukJ4xw0cxuvPIIuPpHD+KHFRM+2hdpm9liNA8MCOVFyM5lHB43jdk4zKW3ew8mSEdGNf+hEL3eJfQ10KA3byWByN6C2dGPKPSUlxocHNjGaOxSgC4SFJ/VpTlQz0cNqRRj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951214; c=relaxed/simple;
	bh=8W375PzrfVO9LealRsAri/9qcosAIl7qz+R5/EoeNAw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=I59bNupYNhaXkUaer9cyJakoezK/h/htmewbBqaZB7JtgRl+J/sAerJEHyEgEdF/sGzXSmNTgZOgLZqE+8R4ADSqz2ntG/tf9RbglP/ftQn00PWU3kimf8DFkaDKxIoPB1ZuLcGHpArgl/t9sec1ySWdGT0eQjZFOqXtvYAf3RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSO8JgGD; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSO8JgGD"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so129377e87.1
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2026 10:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785951210; cv=none;
        d=google.com; s=arc-20260327;
        b=Z3xdYrXB/Ot6RV4PHzwYl/63QDj3hMypFS1ZiRkHYCuBleyRh8kRtEYC0eBcfa/Zzp
         15FnVONEWLK0s9m1ir3iJ0tt/3Z+4UloLPa8o3F5eIokFhjDrAhuUgONpOr/jfmUxybg
         nApnuJ6hcBYpzJZ0VzaDNlejdYBQsNmaYGFdDxVQ/YoFupMBIEn4qoRumiY/JcHF4brg
         jD/fauftMXwatOFfuE5dxxgEhN0uHp8dpz5tB6Y1SAlaoPlhUf+upJFK10yf/Nx1KjFU
         JRlULQtrqnrDQAngcfZdHLuwIHxJgbLAoYcHYUVyx7D/tU4uSsqvOUMENVVMB7g+vRIu
         WHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gjIj7lzD5ZZ0aMlfuwKdTdUTDa+S5Wt5LLNmJC9Wk/k=;
        fh=8sePwlEKWJzWaZLKL/FQ/xQ8qPRTHo6ulT9KyLAJ+Ls=;
        b=Wr+Jr+O9MU93d8/767S+WgdpwBNoALxtAAraLpCSfsFL5PtlrUbGO53Tb2/odT6wre
         peQ8p0g0Jxja3toTo9gKGZTgGaX0EQNK13uCaz1R7BzATjXno+O9yyXlfJF1sDYxc6d1
         Hck+Thoy8uqcKeZWkL3CPPpsg5Sua4B+iKzzRHFMYuDXZh4aIVoKzx7/lElpO1B38ndU
         LGK6cxvBfyKtPh1hc5U5YBcbit/gLHXre9OooN11T+5/XUmELrMs4fD2InRz8KfUZPmw
         +53srH1iVdg0ijcsDiQa3vJSLH27Pv7MDNcwUQNfKj2OoA3YogFhuGioX5Qm7e32vY7x
         8IYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785951210; x=1786556010; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gjIj7lzD5ZZ0aMlfuwKdTdUTDa+S5Wt5LLNmJC9Wk/k=;
        b=NSO8JgGDgCDKKv+IOsvthxFBVMh2H2HXSk6c/qHTUGwQyyWGWJQvIt40UqQeH56VIt
         JYzs0nUPafOKHH84/t2IWLN7pRVNqD+RR79zy3VDBKDRrvfuzxkRDXcZS7morL8M3E+2
         oGN7OE0sqd5Wlb+W5iyWmfJ5lWL5zdyR4qoz49AP1i42sWgFdWp+Dw9XYMOwdV38GMfu
         67kOAh2nQvFcFSdDH/Mh3010siujpL7tQukM8Vbc5Y+LZSbuojV5AaZPmQC14QdCb1rg
         YAry0IQMjmvhchOpqjM+KymcIulFrk7Vd0R5kycoDkh6xSoRM7KFkAPP6BQyv5UDoWeM
         GXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785951210; x=1786556010;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gjIj7lzD5ZZ0aMlfuwKdTdUTDa+S5Wt5LLNmJC9Wk/k=;
        b=M+7AS7JLqC8EnmLF8Fy+JYq8YLx7/lHlD1esPMgbc79wTSrY6OR94uZk4pcSKQaDVE
         ga87vPsql9ifG4O+gZVPB+sdYVWmi7mZ3PgHZgNLUPJTYh7jRwuJzHkbiHtZVcA6Jifj
         CW7V0+zcI0yIEyun9mrJvDhVFcvIR4Aqg6xUokYV8LjaaFuNzdHbCY3QbFbKVoT1/t5w
         65ZWkMSVJlvcq3Sr6B4ho59gj/9qgdr8YcSd6u+XdkwVVFUBLimNKAquv2knjr4UYxPH
         MkbSXe2lHMyNlN3d5YXKkLdBJwarub+T/pmMSoELYgP3y6JMeLFKYypC7V5Mp/aYONQT
         1cUw==
X-Forwarded-Encrypted: i=1; AHgh+Rrfle8eekBPMyDjIEIO+4YPOO1GcwJs9bkoeCuyc+RyXcu+j93qbC+wV80znP5h6QYMRC8mpkt7Z3ZLsUG9iXJTUjZo6rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmjShpwF71BBf1BeLBf0Cuan46RH4dW0Pjs09+1PWHWDQMM1JO
	Fj6c3dH57n4x2O52BiMEa8q4BkZ4OGW8yY8UuzTQVyFT/T9a7lqold2mjhgUBjsUw2yPTjiyzbY
	uH0JiESztHWKjOtEuCLBwPOuecmlqR0vhBVpM
X-Gm-Gg: AR+sD12oq+gkF8kbGhHBDESUV9X+S9CpP5Lkk5wsuajs9M12/a8sIZcuP+CQucYWhvw
	IkcGbp8nXDb3/p8/mr3B+mOvUoPwXtqIDc23vnQGXg9EyfchmNBj2+zPRMerXbSfpoZIx5oO9dZ
	lrFR2qgvaJC2xl+La8YFe0QCBBKLuPbpsZcf1hKUgtv3BdsAqMD4MjItfCPwAvs93J2uahZkxGV
	Jg5a6+Qj5apKsEojb6A1Nl1w/zHaoIARs8mb2nFEkBVFW82bsd6j9Kxw9c4p9BRkr+ofc3Wvuj2
	s+obypycSx0dU7teigxEtEdpoPjckH9BHwAfJWGbxOg=
X-Received: by 2002:a05:6512:114b:b0:5b2:8dc6:3ec4 with SMTP id
 2adb3069b0e04-5b2fe7b7602mr132201e87.18.1785951210010; Wed, 05 Aug 2026
 10:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chengfeng Lin <lin2530632123@gmail.com>
Date: Thu, 6 Aug 2026 01:33:17 +0800
X-Gm-Features: AUfX_mwrMqeWVhLGuxpWkwZ_iXRXkgEaOw6DpiunlUGbuwY2eW6vW6rqEunofnU
Message-ID: <CANGjgdnoz4NdqzOV9+SZaYTc+O_GkNNn5NVp+ZpHUQbp5h-QVQ@mail.gmail.com>
Subject: [REGRESSION] apparmor: AF_UNIX datagram send slowdown after 6456ccbd2ff7
To: john.johansen@canonical.com, georgia.garcia@canonical.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi John and Georgia,

I found a repeatable AF_UNIX datagram send slowdown caused by the exact source
delta of 6456ccbd2ff7 ("apparmor: fix regression in fs based unix sockets when
using old abi"). In a bare-metal parent/child/parent test, a standalone
sendmmsg() workload was 15.30% slower after the change. An independent larger
runner reproduced the slowdown with both sendmmsg() and io_uring SEND, so this
is not specific to io_uring.

#regzbot introduced: 6456ccbd2ff7
#regzbot title: apparmor AF_UNIX datagram send slowdown

The standalone workload uses socketpair(AF_UNIX, SOCK_DGRAM). Each sendmmsg()
call sends 32 messages of 128 bytes. Peer draining and payload validation are
outside the timed region. Each point had 3 warm-up rounds followed by 15
measured rounds of 65,536 messages.

Because 6456ccbd2ff7 was part of an AppArmor series, I isolated its source
delta on one controlled baseline:

  parent 0bfa1c2da7a8: AppArmor topic prefix through 50d56a1a366a
  child  30cb02a874b4: parent plus only the exact two-file 6456ccbd2ff7 diff

The child tree matches the same baseline with the AppArmor prefix advanced
through 6456ccbd2ff7. I used a fresh boot for each point:

  point       mean ns/message
  parent A          343.382
  child             395.831
  parent B          343.259

The child was 15.295% slower than the parent midpoint. Dropping the first
measured round gave 15.289%; parent drift was -0.036%, and the maximum CV was
0.137%. All 45 measured rows passed the payload, length, count, and empty-queue
checks.

The machine was an Intel Core i7-12700KF system with 32 GiB RAM. The workload
was pinned to P-core CPU 2, with governor and EPP set to performance and Turbo
disabled. All three runs used actual preempt=none and reported
/proc/self/attr/current as unconfined.

As a separate check, the larger original runner used matched actual
preempt=full. Its direct sendmmsg() profile was 14.841% slower, and its
io_uring SEND profile was 17.953% slower. I am keeping these results separate
from the standalone percentage.

A separate v6.16.12 -> v6.17.13 perf comparison was directionally consistent.
The children overhead reported for security_unix_may_send was 0.27% in both
v6.16.12 controls and 6.77% at v6.17.13. The latter included the path through
apparmor_unix_may_send(), aa_unix_peer_perm(), and unix_peer_perm(). This was
a release-endpoint comparison rather than the exact source pair above, so I
use it only as supporting path evidence, not as an internal decomposition of
the 15.295% slowdown.

I understand that 6456ccbd2ff7 fixes a real old AppArmor policy ABI issue,
so I am not suggesting a revert. Would it be possible to retain that fix while
avoiding the added cost on this unconfined AF_UNIX datagram send path?

Evidence bundle:

  https://github.com/lcf0399/linux-regression-evidence/tree/7b9862c7ac2d5f9622725912d7f0df95011bcbfd/apparmor-af-unix-send-old-abi-6456cc

Thanks,
Chengfeng
