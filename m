From: serge@hallyn.com (Serge E. Hallyn)
Date: Sat, 21 Oct 2017 11:03:02 -0500
Subject: [RFC PATCH 1/2] security, capabilities: create CAP_TRUSTED
In-Reply-To: <20171021134558.21195-1-nicolas@belouin.fr>
References: <20171021134558.21195-1-nicolas@belouin.fr>
Message-ID: <20171021160302.GA2842@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Nicolas Belouin (nicolas at belouin.fr):
> with CAP_SYS_ADMIN being bloated, the usefulness of using it to
> flag a process to be entrusted for e.g reading and writing trusted
> xattr is near zero.
> CAP_TRUSTED aims to provide userland with a way to mark a process as
> entrusted to do specific (not specially admin-centered) actions. It
> would for example allow a process to red/write the trusted xattrs.

You say "for example".  Are you intending to add more uses?  If so, what
are they?  If not, how about renaming it CAP_TRUSTED_XATTR?

What all does allowing writes to trusted xattrs give you?  There are
the overlayfs whiteouts, what else?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
