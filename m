Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246542236EE
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572514; cv=pass; b=RhqM6NaHwCVFIgcO8A7p0hLnqmchbqQCoSFxn84tMU+Bn07zz/s+XqBv13cHQIHxS7+KnbbtZYsvUpd2YEndDVln4kxKBxfQ2haKSJC+84Qs7NHnqUeDKgZ3HWUUZS9QkjvnGKYu9G2pFZlDvP10IQegnTCc52yc8AqvDpq5hfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572514; c=relaxed/simple;
	bh=52zpGg3kueHgGet8IztKdLA8+tZp4VM8MiDQmi08+vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3BR31uwDLW1m1IkGY/VWzUdPHQjdSOfOeYMbhcNBxu4lN3+tVVHDF0rQB+wEjkynSyiYsOOmq62ASNJmjU2420HllGYYlGzViBd47LlyrQEeVeZUSGeSZKYMHeeTjF3mcapIIW+9PRISVlaxZaFUN2kGl29WMAegz51Jic9dQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MSeCwIrQ; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MSeCwIrQ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c76864f4e58so2012403a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 07:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775572512; cv=none;
        d=google.com; s=arc-20240605;
        b=lSd4TolgphZCbRBsPyptNI9yQ8RNQ/iBI/+x8qcqwbLRBwr9M3GTh+azSVUzKfoGhd
         XqrdfY0HYtemwDBkVlG3Y/n3yY3nNMNf9AA1WJxkRpe3fc2RDEXo39zKrlkhvekrYq/r
         qXF5i84kwJAhj9T+7k/3+GsxFDtHTicPcuo8Rbq25gNlCe9QKZq0c3rHl6529uPld8q5
         hwq/3e0JJWyk/cdbYbhPaV7msElj0YKh7RKqHLrD2edgyEpF1USzxjSC/Pm6h86YteLh
         OHxA2NF9ESA545zOVWit79DJZ6U80iKJYR9ERsLI/5YfJ4Y2Hu1Ihw4eee0z2US+Fw0K
         P0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2qC5HIWFMfgCC7dxk8CsqfkMoXma/koXyhFD7US+Mog=;
        fh=9Rhz3GpT70JpGfMhTMx2v2ovAAdU45R1Pu6ctPX64FQ=;
        b=NDg9STFfa1ibXW2BW30HY212K4P/BxJrvMOzr/PrVnwM1w8qOzRuR7skMH7aMHs/sT
         pTj0m6dyv3zRcTIe7f5XCKeLYb+uvt+fgtyvGlipfhDEGSTMM4H6SKOdYU/ntUX5C4jZ
         lHmVKS1i/1/yMALAA/MtU0Uzej+fIk3A4uavaamV8/kedsL2j/yBPfM3GrCbykFZhB8b
         RrNYC7V5ZzZbSv+xB29JEBVM6nDiHST2zrrl5BWAOD7qys6UFJgveSLDpQz934cQr2Xn
         r043Px/dE1HQ0EkaUXZtemymtlJlNCfwDHYbm6dkq9ZlNSuxJqSSSZXWRy9eITOlARWc
         iM4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775572512; x=1776177312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qC5HIWFMfgCC7dxk8CsqfkMoXma/koXyhFD7US+Mog=;
        b=MSeCwIrQe235ez7W8m6HlUnnYkAayZ4Ym0rsusDeGgjvysabx79GAswgymvMDwdX15
         FZci+n28iUiJBkB94aYRm7cQN12xS5bQ2IvJ7vp9ZFzi01QrgKVQbOKHprEKQycHOx8g
         SwVpNT39z5mwh+sxkYl8XfXHIQ9jVIlGYCnWPXnZEZpiWl4+pK++qko+6KngzKrbFYmN
         zgQHd4/KTK9qCjAsNh4izeax1jtfpXnjJn6T9gERrt5c5odoNSP2z1QDpX+Z7Erj5g4t
         g4zNjphNUV2pniRnLFMWEo9qP5FZzGWUsKuGfgyxQNrK71fbqKDP8i8JNOaOfLepmYl+
         xAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572512; x=1776177312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2qC5HIWFMfgCC7dxk8CsqfkMoXma/koXyhFD7US+Mog=;
        b=ec4S4iEcv979ZECskfeJUUJ6nuxR4a/pCooqMFo+Ymm+kcsZqCtAY2WfcoHSnxp20H
         IAXiSxyVPokWQa1e5jVhFoAj+wc0PUpWop2cLAGpnZf7lsh0morM7NUkRi+jNFKgR12l
         FbmQKE1gOm8Q6auV3p/aTiTB4or+/kppdAQ/pE2by2hvFPBSAD2uM3jM2UvsDaCZ5eO2
         +NNn5kG7a4AWYdIiK/RZPWx6b2ZDD+eb5WcfOKxY0uQyU+mD0HpJxIgxf16dfEzzY09q
         2Bl2BADCshyUuWhI/4gWd2D+Kctwyopl1FxkfpbxGeOJyCxDyWB39ECLo53FQq82xYtt
         ++5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNyA163wPBcDVdf+prQGxY4YnYUpb+NvfKaa5b9py8WN6OQB/2eC8SrT3dzWrKbUWz/AwsLTqkHp6KKdqRz/qWdc9jUOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz00AQgC93oCN8VOKixvVnpL7UifGxjv0hUdaczWuKC7c+K9kFr
	igbbj5gbK27nRI5WMAW3RzO0qgU1Fysq4kwQY59do3WF1HEIFjMpb5vNlBdEggVprpKSLXe7ZHo
	YkBvpxK7G+8Ln6XACUxouApurtAEMAcMv39SCeOUy
X-Gm-Gg: AeBDieshmkQMy5oq6wPn/soA94tSVkN38iFlia9kGRad8c3sK5kZWtI5vecEP6R5V4C
	58ebXkZ4NecierOs5XpM07f2kufzRd0a2nBaT+7aUVMZdXOffd7ja2zpfSNH0hkZkiV9t02ZH6U
	PQWFaPodbWS/TMd0yLU8Ibn4E3mjRPg6lpEbSWFZXF310SZs4IrILrAEnm29KozoRfpYzUmaeSq
	72lAbhKBuDQrlbu5/oogKpZerFUVrl97Zd/z6PMwoWadhKiMImZn2dtnXVBnB/Hdxg1dlzT8dc+
	e6B8u8c=
X-Received: by 2002:a05:6a20:a91f:b0:39f:75a6:16e3 with SMTP id
 adf61e73a8af0-39f75a642ddmr6186836637.2.1775572512468; Tue, 07 Apr 2026
 07:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Apr 2026 10:35:00 -0400
X-Gm-Features: AQROBzCbJor8xEV12qkCxYwq58fXkfkjQP4svTBOSHpDEN5glYblz9lJ5v7xffk
Message-ID: <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > The existing SELinux security model for overlayfs is to allow access if
> > the current task is able to access the top level file (the "user" file)
> > and the mounter's credentials are sufficient to access the lower
> > level file (the "backing" file).  Unfortunately, the current code does
> > not properly enforce these access controls for both mmap() and mprotect=
()
> > operations on overlayfs filesystems.
> >
> > This patch makes use of the newly created security_mmap_backing_file()
> > LSM hook to provide the missing backing file enforcement for mmap()
> > operations, and leverages the backing file API and new LSM blob to
> > provide the necessary information to properly enforce the mprotect()
> > access controls.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Do you have tests for these changes showing the before and after (i.e.
> failing without your patches, passing with them)? I tried running an
> earlier set from Ondrej but they failed.

A few months ago I sent you and Ondrej some feedback on those early
tests from Ondrej, but yes, I also had problems with Ondrej's tests.
I've been using a hacked up combination of the existing tests, some of
Ondrej's additions, and an additional debug/test patch to ensure the
labeling is correct.  It's far from ideal, but I didn't invest time in
test development as I assumed Ondrej would continue his efforts there
(unfortunately it doesn't appear that he has?), and I wanted to focus
on getting a solution as soon as possible for obvious reasons.

--=20
paul-moore.com
