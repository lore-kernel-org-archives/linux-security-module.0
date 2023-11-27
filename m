Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SmVAYnx8"
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A4710E2
	for <linux-security-module@vger.kernel.org>; Mon, 27 Nov 2023 09:07:14 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-daf4f0e3a0fso4243428276.1
        for <linux-security-module@vger.kernel.org>; Mon, 27 Nov 2023 09:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701104833; x=1701709633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVpHcm6eNMtO7gBN1civQcEtrNe2Aaljh7bOFYlkrwU=;
        b=SmVAYnx8zoCZ2VI5Ti7x+9nfyPaGD1wB8NOe6L7Z4vvNLfIyWx9JccNI8yboPp0nqZ
         nsWxFjfwpP/1m9zhJzUVbKFywe1ylZkO47FEXrnffux4jY6vftfdkY6G52t9Mbgz+zKf
         BzMVrUZROWXmgF/AmbOhi3DQzi6txIDJ7oBwYFYUssxViyZDbdhcgJFpYvagxKb2KTtf
         45EAOqk4KSR+QwXgQJ2HiyrG9M9+3xOahI6NhoMQ0HTbhL7de1VTB6/n0pgqpAUngGm1
         3YY80hXIpApzcsv4HvX35fJnZrF+7AzmlncDCa0PiTYOjfv+YtHfRuc10LezZTpUZvpz
         H44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701104833; x=1701709633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVpHcm6eNMtO7gBN1civQcEtrNe2Aaljh7bOFYlkrwU=;
        b=KAXlg4iDchfQoPUk8AZTQKOlwEgI++cB6hqSUM/as8s8XPpdzRxQ3HusQF+z3b4pne
         Oh7LfKGuCrrC3HQmfPWO1ydup7fusir3d3qXy7rRBY3tzL461Ac3IqNRz18IomWJI9Jd
         Y8TKDBBfyHod3Ols5+y4Bl648lOeFz5cO15G2+9bHG5GD4PiF75m1X+qX0rf7iRg3kVw
         +Ti5wVIf8AHWL2Ol6EFAPNJlNgHyn5mhi8EDTPoY0zYaXkRRmQkTt72X432ENIxyauh5
         BwHC7islnCSc+tVLegyqiafMyyMUj0Aeo7KmUWIEWWfK69a2yaz6cqGPjcGMGEfZrly9
         Y/eg==
X-Gm-Message-State: AOJu0Yzo1MgxhyfK6IrFQRx0rVCtnFHYqbq/ruwFWFFGcqmHuf5SHvXb
	GgadguIAj6F5Cy2w7or248XU32uQsCD1kRZYW0QPwC4OmOw+2Nw=
X-Google-Smtp-Source: AGHT+IH2ID4gAteIkSJI7+X55yEB0YPOB3Efis0KpCsyVCs9dt3A0fP/qZxJhsEAB6bIPSYe1pqhSYw+yd4w/Gn0qqs=
X-Received: by 2002:a25:1541:0:b0:da0:6cf3:c629 with SMTP id
 62-20020a251541000000b00da06cf3c629mr9206995ybv.41.1701104833458; Mon, 27 Nov
 2023 09:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122160742.109270-2-paul@paul-moore.com> <9afe7c6e-5753-407a-bdeb-84c0d3735b49@schaufler-ca.com>
In-Reply-To: <9afe7c6e-5753-407a-bdeb-84c0d3735b49@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Nov 2023 12:07:02 -0500
Message-ID: <CAHC9VhT20q5Un3=6kfQv-cjK7QOZkg-UcDL9aL+s5a3HF3SK0g@mail.gmail.com>
Subject: Re: [PATCH] selftests: remove the LSM_ID_IMA check in lsm/lsm_list_modules_test
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 11:51=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 11/22/2023 8:07 AM, Paul Moore wrote:
> > The IMA LSM ID token was removed as IMA isn't yet a proper LSM, but
> > we forgot to remove the check from the selftest.
> >
> > Reported-by: kernel test robot <yujie.liu@intel.com>
> > Closes: https://lore.kernel.org/r/202311221047.a9Dww3vY-lkp@intel.com/
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>
> > ---
> >  tools/testing/selftests/lsm/lsm_list_modules_test.c | 3 ---
> >  1 file changed, 3 deletions(-)

Merged into lsm/dev, thanks.

> > diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tool=
s/testing/selftests/lsm/lsm_list_modules_test.c
> > index 445c02f09c74..9df29b1e3497 100644
> > --- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
> > +++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> > @@ -101,9 +101,6 @@ TEST(correct_lsm_list_modules)
> >               case LSM_ID_TOMOYO:
> >                       name =3D "tomoyo";
> >                       break;
> > -             case LSM_ID_IMA:
> > -                     name =3D "ima";
> > -                     break;
> >               case LSM_ID_APPARMOR:
> >                       name =3D "apparmor";
> >                       break;

--=20
paul-moore.com
