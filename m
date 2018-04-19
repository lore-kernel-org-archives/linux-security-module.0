From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 19 Apr 2018 18:57:34 -0500
Subject: [manpages PATCH] capabilities.7: describe namespaced file
	capabilities
In-Reply-To: <CAG48ez2zb2XgKKRpg=mrhG8_C0p+3gKaNeXyRR_ru5=FLB5pNg@mail.gmail.com>
References: <20180109185218.GA21753@mail.hallyn.com>
	<CAG48ez39UyiqE539rS6RSayj4tPBfQPHPiQ=48Roi55qFJLT7g@mail.gmail.com>
	<06189756-dbc5-ebd0-ccdd-d937d6198530@gmail.com>
	<CAG48ez2zb2XgKKRpg=mrhG8_C0p+3gKaNeXyRR_ru5=FLB5pNg@mail.gmail.com>
Message-ID: <20180419235733.GA8785@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Jann Horn (jannh at google.com):
> On Fri, Apr 13, 2018 at 9:26 PM, Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> > Hello Serge, Jann,
> [...]
> >>> Likewise,
> >>> +.BR getxattr(2)
> >>> +results will be converted and simplified to show a VFS_CAP_REVISION_2
> >>> +extended attribute, if a VFS_CAP_REVISION_3 applies to the caller's
> >>> +namespace, or to map the VFS_CAP_REVISION_3 root user ID into the
> >>> +caller's namespace.
> >
> > I haven't captured that last paragraph in my text. I'm not sure I
> > understand the idea being presented. Serge, could you elaborate?
> 
> Summary: When you read a capability attribute with getxattr(), the
> kernel will rewrite the returned value such that it looks the way it
> would have to look if the filesystem was mounted in your user
> namespace; just like how, when the attribute is written, the caller
> provides an attribute value written as if the filesystem was mounted
> in the caller's user namespace.
> Conceptually, this is mostly the same as the UID conversions applied
> by chown() and stat().

Right.  If it is a V3, and the .rootid maps to a valid uid in your
namespace besides 0, then .rootid will be mapped to the valid user in your
namespace;  if it is 0, then a V2 capability xattr will be presented.
If the real xattr is a V2, then a V2 is presented.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
