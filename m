From: jmorris@namei.org (James Morris)
Date: Thu, 29 Mar 2018 10:58:05 +1100 (AEDT)
Subject: [PATCH v2 1/2] security: convert security hooks to use hlist
In-Reply-To: <CAMp4zn-Pfj3gPH+ZW5EcTLUqHSEbHxQrF_X_FXHgLqwjNZWdPw@mail.gmail.com>
References: <cover.1522185596.git.sargun@sargun.me>
	<0eef34ac71c3768eb58f6c909e5839f2ffee540a.1522185596.git.sargun@sargun.me>
	<34860129-1d23-0e6f-4061-7a6da917cb81@schaufler-ca.com>
	<CAMp4zn-Pfj3gPH+ZW5EcTLUqHSEbHxQrF_X_FXHgLqwjNZWdPw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1803291057560.29811@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 28 Mar 2018, Sargun Dhillon wrote:

> On Wed, Mar 28, 2018 at 9:47 AM, Casey Schaufler <casey@schaufler-ca.com>
> wrote:
> 
> > On 3/27/2018 6:30 PM, Sargun Dhillon wrote:
> > > This changes security_hook_heads to use hlist_heads instead of
> > > the circular doubly-linked list heads. This should cut down
> > > the size of the struct by about half.
> > >
> > > In addition, it allows mutation of the hooks at the tail of the
> > > callback list without having to modify the head. The longer-term
> > > purpose of this is to enable making the heads read only.
> > >
> > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> >
> > James,
> If you're okay with it, I'll go ahead and break this out into its own patch
> with Tetsuo's changes, and you can pick it up.

Sounds good.

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
