clear
%Script to demonstarte Hilbert Transfom - by Dan Hill 24 April 2010
% set these
varname = 'rmidwf25'; 

filename = 'clip_005_truncated.mat';

Fs = 250;
bp = [4 20];
setpt_func = inline( '(max(x) + min (x)) / 2');
amp_func  = @range ;

% run this
load(filename)

x = eval(varname)';
phase = phase_from_hilbert( x, Fs, bp );
t = [1:length(x)]/Fs;
[amp,tops] = get_slow_var(x, phase, amp_func );
setpt = get_slow_var(x, phase, setpt_func );

reconstruction = setpt + (amp/2).*cos(phase);

ax(1) = subplot(4,1,1);
plot(t,x,'k',t,reconstruction,'r')
title(['Data from file: ' filename ', variable: ' varname ' and reconstruction'])
ylabel('Angle')

ax(2) = subplot(4,1,2);
plot(t,x-reconstruction)
title(['Measured - reconstruction'])
ylabel('Angle')
set(gca,'YLim',[-15 15])

ax(3) = subplot(4,1,3);
plot(t,phase/pi)
title('phase');
ylabel('\pi radians')

ax(4) = subplot(4,1,4);
plot(t,x,'k',t,setpt,'r',t,setpt+(amp/2),'r',t,setpt-(amp/2),'r')
for j = 1:length(tops)
 l(j) =   line( t(tops(j)*[1 1]), x(tops(j)) + 7.5*[-1 1]); 
end
title('Midpoint and amplitude');
ylabel('Angle')
xlabel('Time (s)')
set(l,'LineWidth',2','Color',[ 0 0 0])
set(ax,'XLim',t([1 end]))    
set(ax([1 4]),'YLim',[0 180])
set(ax(3),'YLim',[-1 1])


