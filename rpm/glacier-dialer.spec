Name:       glacier-dialer
Summary:    Glacier Dialer
Version:    0.2
Release:    1
Group:      Qt/Qt
License:    LGPL
URL:        https://github.com/nemomobile-ux/glacier-dialer
Source0:    %{name}-%{version}.tar.bz2

Requires:   qt5-qtquickcontrols-nemo
Requires:   voicecall-qt5
Requires:   nemo-qml-plugin-contacts-qt5
Requires:   libqofono-qt5-declarative
Requires:   commhistory-daemon
Requires:   libcommhistory-qt5-declarative
Requires:   libglacierapp >= 0.1.2
Requires:   mapplauncherd-booster-nemomobile

Conflicts:  voicecall-ui-reference

BuildRequires:  qt5-qtcore-devel
BuildRequires:  qt5-qtgui-devel
BuildRequires:  qt5-qtdeclarative-devel
BuildRequires:  qt5-qtopengl-devel
BuildRequires:  qt5-qtdeclarative-qtquick-devel
BuildRequires:  qt5-qmake
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5DBus)
BuildRequires:  desktop-file-utils
BuildRequires:  pkgconfig(glacierapp)
%description
Glacier dialer application

%prep
%setup -q -n %{name}-%{version}

%build
%qmake5
make %{?_smp_mflags}

%install
rm -rf %{buildroot}
%qmake5_install

mkdir -p %{buildroot}%{_libdir}/systemd/user/user-session.target.wants
ln -s ../voicecall-ui-prestart.service %{buildroot}%{_libdir}/systemd/user/user-session.target.wants/

#add system icon for notifications
mkdir -p %{buildroot}%{_datadir}/themes/glacier/meegotouch/icons/
cd %{buildroot}%{_datadir}/themes/glacier/meegotouch/icons/
ln -s /usr/share/glacier-dialer/qml/images/glacier-dialer.png icon-lock-missed-call.png

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%post
systemctl-user --no-block restart voicecall-ui-prestart.service

%files
%defattr(-,root,root,-)
%{_bindir}
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/dbus-1/services/org.glacier.voicecall.ui.service
%{_datadir}/dbus-1/services/com.nokia.telephony.callhistory.service
%{_libdir}/systemd/user/voicecall-ui-prestart.service
%{_libdir}/systemd/user/user-session.target.wants/voicecall-ui-prestart.service
%{_datadir}/themes/glacier/meegotouch/icons/
