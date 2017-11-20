From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 20 Nov 2017 10:03:39 -0600
Subject: Documentation patch for namespaced file capabilities
In-Reply-To: <CAKgNAkiAeqbD=G6hnExh4cC84nA2mU6xdLzzS0F2x1wviEPgHg@mail.gmail.com>
	(Michael Kerrisk's message of "Mon, 20 Nov 2017 10:36:11 +0100")
References: <CAKgNAkiAeqbD=G6hnExh4cC84nA2mU6xdLzzS0F2x1wviEPgHg@mail.gmail.com>
Message-ID: <873759ueck.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

"Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:

> Hi Serge,
>
> At the moment man-pages lacks documentation of the namespaced file
> capability feature that you added with commit
> 8db6c34f1dbc8e06aa016a9b829b06902c3e1340. Would you be able to send a
> patch describing the feature?
>
> Presumably, the patch would be for the capabilities(7) page (or
> perhaps for the user_namespaces(7) page, if that seems more
> appropriate), As well as documenting the semantics, it would be good
> to include an example or two of the notation that is used for the
> xattr names.
>
> Presumably also there will be some changes in userspace tools
> (setcap/getcap?). Do you know anything about what's happening there?


Just a quick summary.

- The capability name does not change.

- From inside a user namespace the capability works as for ``root'' as
  existing tools expect.  (AKA the capability is mapped into the current
  user namespace).

- From outside a user namespace the version of the capability is
  incremented, and a uid of the root user in a user namespace is added
  at the end in the new version of the capability.

So for the capabilities(7) manpage I would add to the File capablities
section:

Since Kernel v4.14 the kernel supports setting file capabilities inside
a user namespace.  In which case an additional uid is stored indicating
the root user of the user namespace the file capabilitity is active in.

When a file is executed and it has a file capability limited to a user
namespace, the kernel takes the uid from the capability and if that uid
matches the uid of the root user of the user namespace or the root user
of an ancestor namespace the capability is applied.  Otherwise the
capability is ignored.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
